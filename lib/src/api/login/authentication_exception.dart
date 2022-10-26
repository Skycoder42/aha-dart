import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_exception.freezed.dart';

@freezed
class AuthenticationException
    with _$AuthenticationException
    implements Exception {
  factory AuthenticationException.invalidStatus(
    int statusCode, [
    Object? error,
  ]) = _Status;

  factory AuthenticationException.invalidChallengeFormat() =
      _InvalidChallengeFormat;

  factory AuthenticationException.invalidCredentials() = _InvalidCredentials;

  factory AuthenticationException.loginCanceled() = _LoginCanceled;

  factory AuthenticationException.logoutFailed() = _LogoutFailed;
}
