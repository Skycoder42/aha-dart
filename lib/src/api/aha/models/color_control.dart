import 'package:color/color.dart';
import 'package:enum_flag/enum_flag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'level_control.dart';

part 'color_control.freezed.dart';
part 'color_control.g.dart';

@xml.XmlEnum()
// ignore: prefer_mixin
enum ColorControlMode with EnumFlag {
  @xml.XmlValue('1')
  hueSaturationMode,
  // ignore: unused_field
  @xml.XmlValue('2')
  _reserved1,
  @xml.XmlValue('4')
  colorTemperatureMode,
  @xml.XmlValue('')
  unknown,
}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class ColorControl with _$ColorControl implements IXmlSerializable {
  static const invalid = ColorControl();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_ColorControlXmlSerializableMixin')
  const factory ColorControl({
    @xml.XmlAttribute(name: 'supported_modes') @Default(0) int supportedModes,
    @xml.XmlAttribute(name: 'current_mode')
    @Default(ColorControlMode.unknown)
        ColorControlMode currentMode,
    @xml.XmlElement() @visibleForTesting String? hue,
    @xml.XmlElement() @visibleForTesting String? saturation,
    @xml.XmlElement(name: 'temperature') int? temperatureKelvin,
  }) = _ColorControl;

  factory ColorControl.fromXmlElement(XmlElement element) =>
      _$_$_ColorControlFromXmlElement(element);

  const ColorControl._();

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
