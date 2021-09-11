import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:meta/meta.dart';

import 'authentication_exception.dart';
import 'login_service.dart';
import 'models/right.dart';
import 'models/session_info.dart';
import 'models/user.dart';
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

  late final ChopperClient _client;

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

  @protected
  FutureOr<UserCredentials> obtainCredentials(List<User> knownUsers);

  @override
  @internal
  FutureOr<Request> onRequest(Request request) async {
    if (request.isLogin) {
      return request;
    }

    if (_sid == SessionInfo.invalidSid) {
      await _performLogin();
    }

    return _copyRequestWithSid(request);
  }

  @override
  @internal
  FutureOr<Request?> authenticate(Request request, Response response) async {
    if (response.statusCode != 403 || request.isLogin) {
      return null;
    }

    await _performLogin();
    return _copyRequestWithSid(request);
  }

  @internal
  // ignore: use_setters_to_change_properties
  void linkToClient(ChopperClient client) {
    _client = client;
  }

  Request _copyRequestWithSid(Request request) => request.copyWith(parameters: {
        ...request.parameters,
        'sid': _sid,
      });

  Future<void> _performLogin() async {
    final loginService = _client.getService<LoginService>();

    final sessionInfo = _extractSessionInfo(
      _sid == SessionInfo.invalidSid
          ? await loginService.getLoginStatus()
          : await loginService.checkSessionValid(sid: _sid),
    );

    final blockTimeout = Future.delayed(
      Duration(seconds: sessionInfo.blockTime),
    );

    final credentials = await obtainCredentials(sessionInfo.users);

    final response = await _solveVersion2Challange(sessionInfo, credentials);

    await blockTimeout;
    final loginResult = _extractSessionInfo(
      await loginService.login(
        username: credentials.username,
        response: response,
      ),
    );

    if (loginResult.sid == SessionInfo.invalidSid) {
      throw AuthenticationException.invalidCredentials();
    }

    _sid = loginResult.sid;
    _rights = loginResult.rights;
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

    return response.body!;
  }
}

extension _RequestX on Request {
  bool get isLogin => url.contains('/login_sid.lua');
}
