import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_credentials.freezed.dart';

@freezed
class UserCredentials with _$UserCredentials {
  const factory UserCredentials({
    required String username,
    required String password,
  }) = _UserCredentials;
}
