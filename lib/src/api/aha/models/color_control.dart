import 'package:color/color.dart';
import 'package:enum_flag/enum_flag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'level_control.dart';

part 'color_control.freezed.dart';
part 'color_control.g.dart';

/// The different color control modes a color control can have
@xml.XmlEnum()
// ignore: prefer_mixin
enum ColorControlMode with EnumFlag {
  @xml.XmlValue('1')
  // ignore: public_member_api_docs
  hueSaturationMode,
  // ignore: unused_field
  @xml.XmlValue('2')
  _reserved1,
  @xml.XmlValue('4')
  // ignore: public_member_api_docs
  colorTemperatureMode,
  @xml.XmlValue('')
  // ignore: public_member_api_docs
  unknown,
}

/// Status information about a color control device, typically a light bulb.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class ColorControl with _$ColorControl implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = ColorControl();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_ColorControlXmlSerializableMixin')
  const factory ColorControl({
    @xml.XmlAttribute(name: 'supported_modes') @Default(0) int supportedModes,
    @xml.XmlAttribute(name: 'current_mode')
    @Default(ColorControlMode.unknown)
        ColorControlMode currentMode,

    /// @nodoc
    @xml.XmlElement() @visibleForOverriding String? hue,

    /// @nodoc
    @xml.XmlElement() @visibleForOverriding String? saturation,
    @xml.XmlElement(name: 'temperature') int? temperatureKelvin,
  }) = _ColorControl;

  /// @nodoc
  @internal
  factory ColorControl.fromXmlElement(XmlElement element) =>
      _$_$_ColorControlFromXmlElement(element);

  const ColorControl._();

  /// Gets the current color in HSV representation.
  ///
  /// If [levelControl] is given, that level is used for the value of the HSV
  /// color. Otherwise, it is set to 100.
  HsvColor? getColor([LevelControl? levelControl]) {
    if (hue == null || saturation == null) {
      return null;
    }

    return HsvColor(
      int.parse(hue!),
      int.parse(saturation!) / 255 * 100,
      (levelControl?.levelPercentage.value ?? 1.0) * 100,
    );
  }
}
