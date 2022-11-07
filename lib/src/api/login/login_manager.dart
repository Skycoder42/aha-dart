import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:meta/meta.dart';

import 'authentication_exception.dart';
import 'login_info.dart';
import 'login_service.dart';
import 'models/right.dart';
import 'models/session_info.dart';
import 'models/sid.dart';
import 'user_credentials.dart';

// ignore: must_be_immutable
abstract class LoginManager implements RequestInterceptor, Authenticator {
  static const _pbkdf2Bits = 256;
  static final _challengeRegexp = RegExp(
    r'^2\$(\d+)\$([0-9a-f]+)\$(\d+)\$([0-9a-f]+)$',
    caseSensitive: false,
  );
  var _rights = AccessRights.empty;

  late final LoginService _loginService;

  Sid sid = Sid.invalid;

  AccessRights get rights => _rights;

  Future<void> login() async {
    final sessionInfo = await _getLoginStatus();
    if (!sessionInfo.sid.isValid) {
      final loginInfo = await _performLogin(sessionInfo, LoginReason.manual);
      if (!loginInfo.sid.isValid) {
        throw AuthenticationException.invalidCredentials();
      }
    }
  }

  Future<void> logout() async {
    if (!sid.isValid) {
      return;
    }

    final sessionInfo = _extractSessionInfo(
      await _loginService.logout(sid.sid),
    );

    if (sessionInfo.sid.isValid) {
      throw AuthenticationException.logoutFailed();
    }
  }

  @protected
  FutureOr<UserCredentials?> obtainCredentials(LoginInfo loginInfo);

  @override
  @internal
  FutureOr<Request> onRequest(Request request) async {
    if (request.isLogin) {
      return request;
    }

    if (!sid.isValid) {
      await _autoLogin(false);
    }

    return _copyRequestWithSid(request);
  }

  @override
  @internal
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? originalRequest,
  ]) async {
    if (response.statusCode != 403 || request.isLogin) {
      return null;
    }

    await _autoLogin(true);
    return _copyRequestWithSid(request);
  }

  @internal
  // ignore: use_setters_to_change_properties
  void setup(LoginService loginService) {
    _loginService = loginService;
  }

  Request _copyRequestWithSid(Request request) => request.copyWith(
        parameters: <String, dynamic>{
          ...request.parameters,
          'sid': sid.sid,
        },
      );

  Future<void> _autoLogin(bool isRefresh) async {
    var sessionInfo = await _getLoginStatus();
    while (!sessionInfo.sid.isValid) {
      sessionInfo = await _performLogin(
        sessionInfo,
        isRefresh ? LoginReason.refresh : LoginReason.auto,
      );
    }
  }

  Future<SessionInfo> _getLoginStatus() async => _extractSessionInfo(
        sid.isValid
            ? await _loginService.checkSessionValid(sid.sid)
            : await _loginService.getLoginStatus(),
      );

  Future<SessionInfo> _performLogin(
    SessionInfo sessionInfo,
    LoginReason reason,
  ) async {
    final blockDelay = sessionInfo.blockTime > 0
        ? Duration(seconds: sessionInfo.blockTime)
        : null;
    final blockTimeout =
        blockDelay != null ? Future<void>.delayed(blockDelay) : null;

    final credentials = await obtainCredentials(
      LoginInfo(
        knownUsers: sessionInfo.users.users ?? const [],
        blockTime: blockDelay,
        reason: reason,
      ),
    );
    if (credentials == null) {
      throw AuthenticationException.loginCanceled();
    }

    final response = await _solveVersion2Challenge(sessionInfo, credentials);

    if (blockTimeout != null) {
      await blockTimeout;
    }

    final loginResult = _extractSessionInfo(
      await _loginService.login(
        username: credentials.username,
        response: response,
      ),
    );

    return loginResult;
  }

  Future<String> _solveVersion2Challenge(
    SessionInfo sessionInfo,
    UserCredentials credentials,
  ) async {
    final challengeMatch = _challengeRegexp.firstMatch(sessionInfo.challenge);
    if (challengeMatch == null) {
      throw AuthenticationException.invalidChallengeFormat();
    }

    final iter1 = int.parse(challengeMatch[1]!);
    final salt1 = hex.decode(challengeMatch[2]!);
    final iter2 = int.parse(challengeMatch[3]!);
    final salt2 = hex.decode(challengeMatch[4]!);

    final pbkdf2Round1 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iter1,
      bits: _pbkdf2Bits,
    );
    final pbkdf2Round2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iter2,
      bits: _pbkdf2Bits,
    );

    final hash1 = await pbkdf2Round1.deriveKey(
      secretKey: SecretKey(utf8.encode(credentials.password)),
      nonce: salt1,
    );
    final hash2 = await pbkdf2Round2.deriveKey(
      secretKey: hash1,
      nonce: salt2,
    );

    return '${hex.encode(salt2)}\$${hex.encode(await hash2.extractBytes())}';
  }

  SessionInfo _extractSessionInfo(Response<SessionInfo> response) {
    if (!response.isSuccessful || response.body == null) {
      throw AuthenticationException.invalidStatus(
        response.statusCode,
        response.error ?? response.bodyString,
      );
    }

    final sessionInfo = response.body!;
    sid = sessionInfo.sid;
    _rights = sessionInfo.accessRights;

    return sessionInfo;
  }
}

extension _RequestX on Request {
  bool get isLogin => url.path.endsWith('/login_sid.lua');
}
