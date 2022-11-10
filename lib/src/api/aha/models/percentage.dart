import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'level.dart';

part 'percentage.freezed.dart';
part 'percentage.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Percentage with _$Percentage implements IXmlSerializable {
  static const _invalidPercentageValue = -9999;

  static const invalid = Percentage();

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

  factory Percentage.fromXmlElement(XmlElement element) =>
      _$_$_PercentageFromXmlElement(element);

  const Percentage._();

  bool isValid() => rawValue != _invalidPercentageValue;

  double get value => rawValue != _invalidPercentageValue ? rawValue / 100 : 0;

  Level toLevel() => Level(level: rawValue * 255 ~/ 100);

  @override
  String toString({bool pretty = false}) => pretty
      ? (rawValue != _invalidPercentageValue ? '$rawValue%' : 'invalid')
      : rawValue.toString();
}
