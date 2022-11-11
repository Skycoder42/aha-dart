import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'level.dart';

part 'percentage.freezed.dart';
part 'percentage.g.dart';

/// The percentage of a percentage controllable device in discrete values.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Percentage with _$Percentage implements IXmlSerializable {
  static const _invalidPercentageValue = -9999;

  /// A value indicating a missing/invalid percentage value.
  static const invalid = Percentage();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_PercentageXmlSerializableMixin')
  @Assert(
    '(rawValue >= 0 && rawValue <= 100) '
        '|| rawValue == Percentage._invalidPercentageValue',
    'rawValue must be in range [0, 100] or $_invalidPercentageValue',
  )
  const factory Percentage({
    @xml.XmlText()
    @Default(Percentage._invalidPercentageValue)
    @visibleForOverriding
        int rawValue,
  }) = _Percentage;

  /// @nodoc
  @internal
  factory Percentage.fromXmlElement(XmlElement element) =>
      _$_$_PercentageFromXmlElement(element);

  /// Create a new percentage instance from the given [value].
  ///
  /// [value] must be an double value in the range `[0, 1]`.
  factory Percentage.create(double value) {
    if (value < 0 || value > 1) {
      throw RangeError.range(value, 0, 1, 'value');
    }
    return Percentage(rawValue: (value * 100).toInt());
  }

  const Percentage._();

  /// Checks if the percentage holds a valid value.
  bool isValid() => rawValue != _invalidPercentageValue;

  /// The double percentage value (0.0 to 1.0)
  double get value => rawValue != _invalidPercentageValue ? rawValue / 100 : 0;

  /// Convert this level into a [Level] object.
  ///
  /// A level of 0 means 0%, a level of 255 means 100%.
  Level toLevel() => Level(level: rawValue * 255 ~/ 100);

  @override
  String toString({bool pretty = false}) => pretty
      ? (rawValue != _invalidPercentageValue ? '$rawValue%' : 'invalid')
      : rawValue.toString();
}
