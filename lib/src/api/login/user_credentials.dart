import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_credentials.freezed.dart';

/// User credentials to log into the fritz.box
@freezed
class UserCredentials with _$UserCredentials {
  /// Default constructor.
  const factory UserCredentials({
    /// The user to login with.
    required String username,

    /// The password of this user.
    ///
    /// Note: The password is never sent to the remote directly. Instead, a
    /// challenge response algorithm is used that uses this password to prove
    /// it's possession to the remote.
    required String password,
  }) = _UserCredentials;
}
