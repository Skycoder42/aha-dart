import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'percentage.dart';

part 'level.freezed.dart';
part 'level.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Level with _$Level implements IXmlSerializable {
  static const invalid = Level();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_LevelXmlSerializableMixin')
  @Assert(
    'level >= 0 && level <= 255',
    'level must be in range [0, 255]',
  )
  const factory Level({
    @xml.XmlText() @Default(0) int level,
  }) = _Level;

  factory Level.fromXmlElement(XmlElement element) =>
      _$_$_LevelFromXmlElement(element);

  factory Level.fromString(String level) => Level(level: int.parse(level));

  const Level._();

  Percentage toPercentage() => Percentage(rawValue: level * 100 ~/ 255);

  @override
  String toString() => level.toString();
}
