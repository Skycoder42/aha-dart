import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'voltage.freezed.dart';
part 'voltage.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Voltage with _$Voltage implements IXmlSerializable {
  static const invalid = Voltage();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_VoltageXmlSerializableMixin')
  const factory Voltage({
    @xml.XmlText() @visibleForOverriding @Default(0) int rawValue,
  }) = _Voltage;

  factory Voltage.fromXmlElement(XmlElement element) =>
      _$_$_VoltageFromXmlElement(element);

  factory Voltage.fromString(String rawValue) =>
      Voltage(rawValue: int.parse(rawValue));

  const Voltage._();

  int get milliVolts => rawValue;

  double get volts => rawValue / 1000;

  @override
  String toString() => '$rawValue mV';
}
