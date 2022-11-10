import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'power.freezed.dart';
part 'power.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Power with _$Power implements IXmlSerializable {
  static const invalid = Power();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_PowerXmlSerializableMixin')
  const factory Power({
    @xml.XmlText() @visibleForOverriding @Default(0) int rawValue,
  }) = _Power;

  factory Power.fromXmlElement(XmlElement element) =>
      _$_$_PowerFromXmlElement(element);

  factory Power.fromString(String rawValue) =>
      Power(rawValue: int.parse(rawValue));

  const Power._();

  int get milliWatts => rawValue;

  double get watts => rawValue / 1000;

  @override
  String toString() => '$rawValue mW';
}
