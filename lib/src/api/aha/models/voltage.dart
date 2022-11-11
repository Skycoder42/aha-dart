import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'voltage.freezed.dart';
part 'voltage.g.dart';

/// An electric voltage value.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Voltage with _$Voltage implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = Voltage();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_VoltageXmlSerializableMixin')
  const factory Voltage({
    @xml.XmlText() @visibleForOverriding @Default(0) int rawValue,
  }) = _Voltage;

  /// @nodoc
  @internal
  factory Voltage.fromXmlElement(XmlElement element) =>
      _$_$_VoltageFromXmlElement(element);

  /// @nodoc
  @internal
  factory Voltage.fromString(String rawValue) =>
      Voltage(rawValue: int.parse(rawValue));

  const Voltage._();

  /// Returns the energy in milli Volts
  int get milliVolts => rawValue;

  /// Returns the energy in Volts
  double get volts => rawValue / 1000;

  @override
  String toString() => '$rawValue mV';
}
