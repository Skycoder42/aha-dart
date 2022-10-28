import 'package:color/color.dart';
import 'package:enum_flag/enum_flag.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'level_control.dart';

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

@xml.XmlSerializable(createMixin: true)
@immutable
class ColorControl extends XmlEquatable<ColorControl>
    with _$ColorControlXmlSerializableMixin, _ColorControlEquality {
  @xml.XmlAttribute(name: 'supported_modes')
  final int supportedModes;

  @xml.XmlAttribute(name: 'current_mode')
  final ColorControlMode currentMode;

  @xml.XmlElement()
  @visibleForTesting
  final String? hue;

  @xml.XmlElement()
  @visibleForTesting
  final String? saturation;

  @xml.XmlElement(name: 'temperature')
  final int? temperatureKelvin;

  const ColorControl({
    required this.supportedModes,
    required this.currentMode,
    required this.hue,
    required this.saturation,
    required this.temperatureKelvin,
  });

  factory ColorControl.fromXmlElement(XmlElement element) =>
      _$ColorControlFromXmlElement(element);

  HsvColor? getColor([LevelControl? levelControl]) {
    if (hue == null || saturation == null) {
      return null;
    }

    return HsvColor(
      int.parse(hue!),
      int.parse(saturation!) / 255 * 100,
      (levelControl?.levelPercentage.getPercentage() ?? 1.0) * 100,
    );
  }
}

mixin _ColorControlEquality on XmlEquatable<ColorControl> {
  @override
  List<Object?> get props => [
        self.supportedModes,
        self.currentMode,
        self.hue,
        self.saturation,
        self.temperatureKelvin,
      ];
}
