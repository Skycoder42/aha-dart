import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'hkr_temperature.freezed.dart';
part 'hkr_temperature.g.dart';

/// The state of a thermostat.
@freezed
class HkrState with _$HkrState {
  /// Device is turned on for the given temperature.
  const factory HkrState(
    /// The configured temperature in celsius.
    double celsiusValue,
  ) = _Value;

  /// Device is fully turned on.
  const factory HkrState.on() = _On;

  /// Device is turned off.
  const factory HkrState.off() = _Off;

  /// Device state is not known.
  const factory HkrState.invalid() = _Invalid;
}

/// The temperature configuration state of a thermostat.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class HkrTemperature
    with _$HkrTemperature
    implements IXmlSerializable {
  static const _offValue = 253;
  static const _onValue = 254;
  static const _invalidValue = 255;

  /// @nodoc
  @internal
  static const invalid = HkrTemperature();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_HkrTemperatureXmlSerializableMixin')
  const factory HkrTemperature({
    @xml.XmlText()
    @visibleForOverriding
    @Default(HkrTemperature._invalidValue)
    int rawValue,
  }) = _HkrTemperature;

  /// @nodoc
  @internal
  factory HkrTemperature.fromXmlElement(XmlElement element) =>
      _$_$_HkrTemperatureFromXmlElement(element);

  /// @nodoc
  @internal
  factory HkrTemperature.fromString(String rawValue) =>
      HkrTemperature(rawValue: int.parse(rawValue));

  /// Create a new HkrTemperature object from the given [value].
  factory HkrTemperature.create(HkrState value) => value.when(
        (celsiusValue) => HkrTemperature(rawValue: (celsiusValue * 2).toInt()),
        on: () => const HkrTemperature(rawValue: _onValue),
        off: () => const HkrTemperature(rawValue: _offValue),
        invalid: () => HkrTemperature.invalid,
      );

  const HkrTemperature._();

  /// The current state of the thermostat
  HkrState get state {
    if (rawValue == _onValue) {
      return const HkrState.on();
    } else if (rawValue == _offValue) {
      return const HkrState.off();
    } else if (rawValue == _invalidValue) {
      return const HkrState.invalid();
    } else {
      return HkrState(rawValue / 2);
    }
  }

  @override
  String toString({bool pretty = false}) =>
      pretty ? state.toString() : rawValue.toString();
}
