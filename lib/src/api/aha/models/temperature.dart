import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'temperature.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Temperature extends XmlEquatable<Temperature>
    with _$TemperatureXmlSerializableMixin, _TemperatureEquality {
  @xml.XmlElement()
  @visibleForTesting
  final int? celsius;

  @xml.XmlElement()
  @visibleForTesting
  final int? offset;

  const Temperature({
    required this.celsius,
    required this.offset,
  });

  factory Temperature.fromXmlElement(XmlElement element) =>
      _$TemperatureFromXmlElement(element);

  double getTemperatureCelsius() => (celsius ?? 0) / 10;

  double getOffsetCelsius() => (offset ?? 0) / 10;

  @override
  String toString() =>
      '${getTemperatureCelsius()}°C (Offset: ${getOffsetCelsius()}°C)';
}

mixin _TemperatureEquality on XmlEquatable<Temperature> {
  @override
  List<Object?> get props => [
        self.getTemperatureCelsius(),
        self.getOffsetCelsius(),
      ];
}