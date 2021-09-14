import 'package:freezed_annotation/freezed_annotation.dart';

import 'models/user.dart';

part 'login_info.freezed.dart';

enum LoginReason {
  manual,
  auto,
  refresh,
}

@freezed
class LoginInfo with _$LoginInfo {
  const factory LoginInfo({
    required List<User> knownUsers,
    required Duration? blockTime,
    required LoginReason reason,
  }) = _LoginInfo;
}
