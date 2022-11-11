import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'percentage.dart';

part 'level.freezed.dart';
part 'level.g.dart';

/// The level of a level controllable device in discrete values.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Level with _$Level implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = Level();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_LevelXmlSerializableMixin')
  @Assert(
    'level >= 0 && level <= 255',
    'level must be in range [0, 255]',
  )
  const factory Level({
    @xml.XmlText() @Default(0) int level,
  }) = _Level;

  /// @nodoc
  @internal
  factory Level.fromXmlElement(XmlElement element) =>
      _$_$_LevelFromXmlElement(element);

  /// @nodoc
  @internal
  factory Level.fromString(String level) => Level(level: int.parse(level));

  /// Create a new level instance from the given [level].
  ///
  /// [level] must be an integer value in the range `[0, 255]`.
  factory Level.create(int level) {
    RangeError.checkValueInInterval(level, 0, 255, 'level');
    return Level(level: level);
  }

  const Level._();

  /// Convert this level into a [Percentage] object.
  ///
  /// A level of 0 means 0%, a level of 255 means 100%.
  // ignore: invalid_use_of_visible_for_overriding_member
  Percentage toPercentage() => Percentage(rawValue: level * 100 ~/ 255);

  @override
  String toString() => level.toString();
}
