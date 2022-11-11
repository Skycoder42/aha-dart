import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'color.dart';
import 'name.dart';

part 'hs_color.freezed.dart';
part 'hs_color.g.dart';

/// A predefined HSV color.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class HsColor with _$HsColor implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = HsColor();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_HsColorXmlSerializableMixin')
  const factory HsColor({
    @xml.XmlAttribute(name: 'hue_index') @Default(0) int hueIndex,
    @xml.XmlElement() @Default(Name.invalid) Name name,
    @xml.XmlElement(name: 'color', isSelfClosing: true)
    @Default(<Color>[])
        List<Color> colors,
  }) = _HsColor;

  /// @nodoc
  @internal
  factory HsColor.fromXmlElement(XmlElement element) =>
      _$_$_HsColorFromXmlElement(element);
}
