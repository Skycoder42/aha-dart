import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'energy.freezed.dart';
part 'energy.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Energy with _$Energy implements IXmlSerializable {
  static const invalid = Energy();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_EnergyXmlSerializableMixin')
  const factory Energy({
    @xml.XmlText() @visibleForOverriding @Default(0) int rawValue,
  }) = _Energy;

  factory Energy.fromXmlElement(XmlElement element) =>
      _$_$_EnergyFromXmlElement(element);

  factory Energy.fromString(String rawValue) =>
      Energy(rawValue: int.parse(rawValue));

  const Energy._();

  int get wattHours => rawValue;

  int get joule => rawValue * 3600;

  @override
  String toString() => '$rawValue Wh';
}
