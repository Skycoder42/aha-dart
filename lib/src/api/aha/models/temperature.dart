import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'temperature.freezed.dart';
part 'temperature.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Temperature with _$Temperature implements IXmlSerializable {
  static const invalid = Temperature();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_TemperatureXmlSerializableMixin')
  const factory Temperature({
    @xml.XmlElement(name: 'celsius') @visibleForOverriding int? rawCelsius,
    @xml.XmlElement(name: 'offset') @visibleForOverriding int? rawOffset,
  }) = _Temperature;

  factory Temperature.fromXmlElement(XmlElement element) =>
      _$_$_TemperatureFromXmlElement(element);

  factory Temperature.fromString(String rawCelsius) =>
      Temperature(rawCelsius: int.parse(rawCelsius));

  const Temperature._();

  /// The temperature in celsius
  double get temperature => (rawCelsius ?? 0) / 10;

  /// The temperature offset in celsius
  double get offset => (rawOffset ?? 0) / 10;

  @override
  String toString({bool pretty = false}) => pretty
      ? (rawOffset != null
          ? '$temperature°C (Offset: $offset°C)'
          : '$temperature°C')
      : rawCelsius.toString();
}
