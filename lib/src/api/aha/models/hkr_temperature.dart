import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'hkr_temperature.freezed.dart';
part 'hkr_temperature.g.dart';

@freezed
class HkrTemperatureValue with _$HkrTemperatureValue {
  const factory HkrTemperatureValue(double celsiusValue) = _Value;
  const factory HkrTemperatureValue.on() = _On;
  const factory HkrTemperatureValue.off() = _Off;
  const factory HkrTemperatureValue.invalid() = _Invalid;
}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class HkrTemperature
    with _$HkrTemperature
    implements IXmlSerializable {
  static const _offValue = 253;
  static const _onValue = 254;
  static const _invalidValue = 255;

  static const invalid = HkrTemperature();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_HkrTemperatureXmlSerializableMixin')
  const factory HkrTemperature({
    @xml.XmlText()
    @visibleForOverriding
    @Default(HkrTemperature._invalidValue)
        int rawValue,
  }) = _HkrTemperature;

  factory HkrTemperature.fromXmlElement(XmlElement element) =>
      _$_$_HkrTemperatureFromXmlElement(element);

  factory HkrTemperature.fromString(String rawValue) =>
      HkrTemperature(rawValue: int.parse(rawValue));

  const HkrTemperature._();

  HkrTemperatureValue get value {
    if (rawValue == _onValue) {
      return const HkrTemperatureValue.on();
    } else if (rawValue == _offValue) {
      return const HkrTemperatureValue.off();
    } else if (rawValue == _invalidValue) {
      return const HkrTemperatureValue.invalid();
    } else {
      return HkrTemperatureValue(rawValue / 2);
    }
  }

  @override
  String toString({bool pretty = false}) =>
      pretty ? value.toString() : rawValue.toString();
}
