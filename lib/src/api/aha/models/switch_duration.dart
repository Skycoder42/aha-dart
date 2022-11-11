import 'package:freezed_annotation/freezed_annotation.dart';

part 'switch_duration.freezed.dart';

/// A wrapper for a [Duration] to pass to the API
@freezed
class SwitchDuration with _$SwitchDuration {
  /// Create a switch duration from the given [duration].
  const factory SwitchDuration.create(
    /// The duration to be wrapped.
    Duration duration,
  ) = _SwitchDuration;

  @override
  String toString() => (duration.inMilliseconds / 100).toString();
}
