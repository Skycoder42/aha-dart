import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

import 'hs_defaults.dart';
import 'temperature_defaults.dart';

part 'color_defaults.freezed.dart';
part 'color_defaults.g.dart';

/// A collection of default HSV colors to choose from for color control devices.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class ColorDefaults with _$ColorDefaults implements IXmlConvertible {
  /// @nodoc
  @internal
  static const elementName = 'colordefaults';

  /// @nodoc
  @internal
  static const invalid = ColorDefaults();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: ColorDefaults.elementName)
  @With.fromString(r'_$_$_ColorDefaultsXmlSerializableMixin')
  const factory ColorDefaults({
    @xml.XmlElement(name: 'hsdefaults')
    @Default(HsDefaults.invalid)
    HsDefaults hsDefaults,
    @xml.XmlElement(name: 'temperaturedefaults')
    @Default(TemperatureDefaults.invalid)
    TemperatureDefaults temperatureDefaults,
  }) = _ColorDefaults;

  /// @nodoc
  @internal
  factory ColorDefaults.fromXmlElement(XmlElement element) =>
      _$_$_ColorDefaultsFromXmlElement(element);
}
