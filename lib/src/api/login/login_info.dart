import 'package:freezed_annotation/freezed_annotation.dart';

import 'authentication_exception.dart';
import 'login_manager.dart';
import 'models/user.dart';

part 'login_info.freezed.dart';

/// The reason why a login was requested.
enum LoginReason {
  /// An explicit login was triggered.
  ///
  /// This happens if you call [LoginManager.login].
  manual,

  /// An implicit login was triggered.
  ///
  /// This happens if you call any of the AHA-Apis of the client without
  /// previously authenticating. Rejecting such an automatic login will cause
  /// the [AuthenticationException.loginCanceled] exception to be thrown by the
  /// original request.
  auto,

  /// A previously authentication session needs to be refreshed.
  ///
  /// This typically happens if your session is idle for to long and times out.
  refresh,
}

/// An information object about a login requested via
/// [LoginManager.obtainCredentials].
@freezed
class LoginInfo with _$LoginInfo {
  /// Default constructor.
  const factory LoginInfo({
    /// A list of known users, if one is provided by the remote.
    ///
    /// Most of the time, this list is either missing or incomplete. You can use
    /// it to provide the user with a list of known accounts, but you should
    /// always allow them to enter their own name.
    required List<User> knownUsers,

    /// Indicates that the login is blocked for the given duration.
    ///
    /// This can happen if a previous login failed. You should display this to
    /// the user and wait with submission of new credentials until this time
    /// has expired, otherwise a login will automatically fail.
    required Duration? blockTime,

    /// The reason why a login is requested.
    required LoginReason reason,
  }) = _LoginInfo;
}
