import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'temperature.freezed.dart';
part 'temperature.g.dart';

/// The temperature of a temperature measurement device.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Temperature with _$Temperature implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = Temperature();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_TemperatureXmlSerializableMixin')
  const factory Temperature({
    @xml.XmlElement(name: 'celsius') @visibleForOverriding int? rawCelsius,
    @xml.XmlElement(name: 'offset') @visibleForOverriding int? rawOffset,
  }) = _Temperature;

  /// @nodoc
  @internal
  factory Temperature.fromXmlElement(XmlElement element) =>
      _$_$_TemperatureFromXmlElement(element);

  /// @nodoc
  @internal
  factory Temperature.fromString(String rawCelsius) =>
      Temperature(rawCelsius: int.parse(rawCelsius));

  const Temperature._();

  // ignore: public_member_api_docs
  double get temperature => (rawCelsius ?? 0) / 10;

  // ignore: public_member_api_docs
  double get offset => (rawOffset ?? 0) / 10;

  @override
  String toString({bool pretty = false}) => pretty
      ? (rawOffset != null
          ? '$temperature°C (Offset: $offset°C)'
          : '$temperature°C')
      : rawCelsius.toString();
}
