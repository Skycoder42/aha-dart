import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'level.dart';
import 'percentage.dart';

part 'level_control.freezed.dart';
part 'level_control.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class LevelControl with _$LevelControl implements IXmlSerializable {
  static const invalid = LevelControl();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_LevelControlXmlSerializableMixin')
  const factory LevelControl({
    @xml.XmlElement() @Default(Level.invalid) Level level,
    @xml.XmlElement(name: 'levelpercentage')
    @Default(Percentage.invalid)
        Percentage levelPercentage,
  }) = _LevelControl;

  factory LevelControl.fromXmlElement(XmlElement element) =>
      _$_$_LevelControlFromXmlElement(element);
}
