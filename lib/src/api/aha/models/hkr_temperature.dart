import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'hkr_temperature.freezed.dart';
part 'hkr_temperature.g.dart';

const _offValue = 253;
const _onValue = 254;
const _invalidValue = 255;

@freezed
class HkrTemperatureValue with _$HkrTemperatureValue {
  const factory HkrTemperatureValue(double celsiusValue) = _Value;
  const factory HkrTemperatureValue.on() = _On;
  const factory HkrTemperatureValue.off() = _Off;
  const factory HkrTemperatureValue.invalid() = _Invalid;
}

@xml.XmlSerializable(createMixin: true)
@immutable
class HkrTemperatur extends XmlEquatable<HkrTemperatur>
    with _$HkrTemperaturXmlSerializableMixin, _HkrTemperaturEquality {
  @xml.XmlText()
  final int rawValue;

  const HkrTemperatur({
    required this.rawValue,
  });

  factory HkrTemperatur.fromXmlElement(XmlElement element) =>
      _$HkrTemperaturFromXmlElement(element);

  HkrTemperatureValue getValue() {
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
  String toString() => getValue().toString();
}

mixin _HkrTemperaturEquality on XmlEquatable<HkrTemperatur> {
  @override
  List<Object?> get props => [
        self.getValue(),
      ];
}
