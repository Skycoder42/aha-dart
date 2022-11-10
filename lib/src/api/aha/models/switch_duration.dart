import 'package:freezed_annotation/freezed_annotation.dart';

part 'switch_duration.freezed.dart';

@freezed
class SwitchDuration with _$SwitchDuration {
  const factory SwitchDuration(Duration duration) = _SwitchDuration;

  @override
  String toString() => (duration.inMilliseconds / 100).toString();
}
