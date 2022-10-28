import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'percentage.dart';

part 'level_control.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class LevelControl extends XmlEquatable<LevelControl>
    with _$LevelControlXmlSerializableMixin, _LevelControlEquality {
  @xml.XmlElement()
  final int level;

  @xml.XmlElement(name: 'levelpercentage')
  final Percentage levelPercentage;

  const LevelControl({
    required this.level,
    required this.levelPercentage,
  }) : assert(
          level >= 0 && level <= 255,
          'level must be in range [0, 255]',
        );

  factory LevelControl.fromXmlElement(XmlElement element) =>
      _$LevelControlFromXmlElement(element);
}

mixin _LevelControlEquality on XmlEquatable<LevelControl> {
  @override
  List<Object?> get props => [
        self.level,
        self.levelPercentage,
      ];
}
