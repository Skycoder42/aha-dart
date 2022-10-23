import 'package:freezed_annotation/freezed_annotation.dart';

import '../../util/text_converter.dart';

part 'switch_status.freezed.dart';

@freezed
class SwitchStatus with _$SwitchStatus {
  static const TextTypeConverter<SwitchStatus> converter =
      _SwitchStatusConverter();

  const SwitchStatus._();

  const factory SwitchStatus.on() = _On;
  const factory SwitchStatus.off() = _Off;

  // ignore: avoid_positional_boolean_parameters
  factory SwitchStatus.fromBool(bool value) =>
      value ? const SwitchStatus.on() : const SwitchStatus.off();

  bool get asBool => when(
        on: () => true,
        off: () => false,
      );
}

class _SwitchStatusConverter implements TextTypeConverter<SwitchStatus> {
  const _SwitchStatusConverter();

  @override
  SwitchStatus decode(String data) {
    switch (data) {
      case '0':
        return const SwitchStatus.off();
      case '1':
        return const SwitchStatus.on();
      default:
        throw ArgumentError.value(data, 'data', 'must be either 0 or 1');
    }
  }

  @override
  String encode(SwitchStatus data) => data.when(
        on: () => '1',
        off: () => '0',
      );
}
