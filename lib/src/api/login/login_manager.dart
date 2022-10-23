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
import 'user_credentials.dart';

// ignore: must_be_immutable
abstract class LoginManager implements RequestInterceptor, Authenticator {
  static const _pbkd2Bits = 256;
  static final _challangeRegexp = RegExp(
    r'^2\$(\d+)\$([0-9a-f]+)\$(\d+)\$([0-9a-f]+)$',
    caseSensitive: false,
  );

  var _sid = SessionInfo.invalidSid;
  var _rights = const <Right>[];

  late final LoginService _loginService;

  List<Right> get rights => _rights;

  String get sid => _sid;
  set sid(String sid) {
    if (sid.length != 16) {
      // TODO validate with regexp
      throw ArgumentError.value(
        sid,
        'sid',
        'must be a 64 bit hex encoded integer',
      );
    }

    _sid = sid;
  }

  Future<void> login() async {
    final sessionInfo = await _getLoginStatus();
    if (sessionInfo.sid == SessionInfo.invalidSid) {
      final loginInfo = await _performLogin(sessionInfo, LoginReason.manual);

      if (loginInfo.sid == SessionInfo.invalidSid) {
        throw AuthenticationException.invalidCredentials();
      }
    }
  }

  Future<void> logout() async {
    if (_sid == SessionInfo.invalidSid) {
      return;
    }

    final sessionInfo = _extractSessionInfo(
      await _loginService.logout(sid: _sid),
    );

    if (sessionInfo.sid != SessionInfo.invalidSid) {
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

    if (_sid == SessionInfo.invalidSid) {
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
          'sid': _sid,
        },
      );

  Future<void> _autoLogin(bool isRefresh) async {
    var sessionInfo = await _getLoginStatus();
    while (sessionInfo.sid == SessionInfo.invalidSid) {
      sessionInfo = await _performLogin(
        sessionInfo,
        isRefresh ? LoginReason.refresh : LoginReason.auto,
      );
    }
  }

  Future<SessionInfo> _getLoginStatus() async => _extractSessionInfo(
        _sid == SessionInfo.invalidSid
            ? await _loginService.getLoginStatus()
            : await _loginService.checkSessionValid(sid: _sid),
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
        knownUsers: sessionInfo.users,
        blockTime: blockDelay,
        reason: reason,
      ),
    );
    if (credentials == null) {
      throw AuthenticationException.loginCanceled();
    }

    final response = await _solveVersion2Challange(sessionInfo, credentials);

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

  Future<String> _solveVersion2Challange(
    SessionInfo sessionInfo,
    UserCredentials credentials,
  ) async {
    final challangeMatch = _challangeRegexp.firstMatch(sessionInfo.challange);
    if (challangeMatch == null) {
      throw AuthenticationException.invalidChallangeFormat();
    }

    final iter1 = int.parse(challangeMatch[1]!);
    final salt1 = hex.decode(challangeMatch[2]!);
    final iter2 = int.parse(challangeMatch[3]!);
    final salt2 = hex.decode(challangeMatch[4]!);

    final pbkdfRound1 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iter1,
      bits: _pbkd2Bits,
    );
    final pbkdfRound2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iter2,
      bits: _pbkd2Bits,
    );

    final hash1 = await pbkdfRound1.deriveKey(
      secretKey: SecretKey(utf8.encode(credentials.password)),
      nonce: salt1,
    );
    final hash2 = await pbkdfRound2.deriveKey(
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
    _sid = sessionInfo.sid;
    _rights = sessionInfo.rights;

    return sessionInfo;
  }
}

extension _RequestX on Request {
  bool get isLogin => url.path.endsWith('/login_sid.lua');
}
