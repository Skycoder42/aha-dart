import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'percentage.dart';

part 'level_control.freezed.dart';
part 'level_control.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class LevelControl with _$LevelControl implements IXmlSerializable {
  static const invalid = LevelControl();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_LevelControlXmlSerializableMixin')
  @Assert(
    'level >= 0 && level <= 255',
    'level must be in range [0, 255]',
  )
  const factory LevelControl({
    @xml.XmlElement() @Default(0) int level,
    @xml.XmlElement(name: 'levelpercentage')
    @Default(Percentage.invalid)
        Percentage levelPercentage,
  }) = _LevelControl;

  factory LevelControl.fromXmlElement(XmlElement element) =>
      _$_$_LevelControlFromXmlElement(element);
}
