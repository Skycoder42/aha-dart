import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'hkr_temperature.g.dart';

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

  double getValue() => rawValue / 2;

  @override
  String toString() => '${getValue()}°C';
}

mixin _HkrTemperaturEquality on XmlEquatable<HkrTemperatur> {
  @override
  List<Object?> get props => [self.getValue()];
}
