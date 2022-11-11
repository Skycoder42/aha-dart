import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

import 'temp.dart';

part 'temperature_defaults.freezed.dart';
part 'temperature_defaults.g.dart';

/// A collection of default light color temperatures.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class TemperatureDefaults
    with _$TemperatureDefaults
    implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = TemperatureDefaults();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_TemperatureDefaultsXmlSerializableMixin')
  const factory TemperatureDefaults({
    @xml.XmlElement(name: 'temp', isSelfClosing: true)
    @Default(<Temp>[])
        List<Temp> temperatures,
  }) = _TemperatureDefaults;

  /// @nodoc
  @internal
  factory TemperatureDefaults.fromXmlElement(XmlElement element) =>
      _$_$_TemperatureDefaultsFromXmlElement(element);
}
