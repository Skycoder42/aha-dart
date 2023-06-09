import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_exception.freezed.dart';

/// An error that can be thrown by an AHA API request if there is a problem
/// with the authentication.
///
/// {@macro aha_reference}
@freezed
class AuthenticationException
    with _$AuthenticationException
    implements Exception {
  /// Indicates that a login request failed with an unexpected [statusCode].
  ///
  /// The full error response is found in [error].
  factory AuthenticationException.invalidStatus(
    /// The HTTP status code of the failed request
    int statusCode, [
    /// The error response body, if one was given.
    Object? error,
  ]) = _Status;

  /// Indicates that the library is unable to handle the provided authentication
  /// challenge.
  ///
  /// If you get this error, your Fritz-OS might be to old and thus not
  /// supported by this library.
  ///
  /// {@macro aha_reference}
  factory AuthenticationException.invalidChallengeFormat() =
      _InvalidChallengeFormat;

  /// Indicates that the provided credentials are invalid.
  factory AuthenticationException.invalidCredentials() = _InvalidCredentials;

  /// The authentication was canceled by the user.
  factory AuthenticationException.loginCanceled() = _LoginCanceled;

  /// The remote rejected the logout and your session is still active.
  ///
  /// Honestly, this should never happen, but theoretically it can, so here is
  /// this error. If you ever get this, please open an issue, because it most
  /// likely means something else is broken.
  factory AuthenticationException.logoutFailed() = _LogoutFailed;
}
