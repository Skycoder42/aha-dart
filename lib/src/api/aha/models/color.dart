import 'package:color/color.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'color.freezed.dart';
part 'color.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Color with _$Color implements IXmlSerializable {
  static const invalid = Color();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_ColorXmlSerializableMixin')
  @Assert('hue >= 0 && hue <= 359', 'hue must be in range [0, 359]')
  @Assert('sat >= 0 && sat <= 255', 'sat must be in range [0, 255]')
  @Assert('val >= 0 && val <= 255', 'val must be in range [0, 255]')
  const factory Color({
    @xml.XmlAttribute(name: 'sat_index') @Default(0) int satIndex,
    @xml.XmlAttribute() @visibleForOverriding @Default(0) int hue,
    @xml.XmlAttribute() @visibleForOverriding @Default(0) int sat,
    @xml.XmlAttribute() @visibleForOverriding @Default(0) int val,
  }) = _Color;

  factory Color.fromXmlElement(XmlElement element) =>
      _$_$_ColorFromXmlElement(element);

  const Color._();

  HsvColor get color => HsvColor(
        hue,
        sat / 255 * 100,
        val / 255 * 100,
      );
}
