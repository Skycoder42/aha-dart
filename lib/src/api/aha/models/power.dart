import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'power.freezed.dart';
part 'power.g.dart';

/// An electric power value.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Power with _$Power implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = Power();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_PowerXmlSerializableMixin')
  const factory Power({
    @xml.XmlText() @visibleForOverriding @Default(0) int rawValue,
  }) = _Power;

  /// @nodoc
  @internal
  factory Power.fromXmlElement(XmlElement element) =>
      _$_$_PowerFromXmlElement(element);

  /// @nodoc
  @internal
  factory Power.fromString(String rawValue) =>
      Power(rawValue: int.parse(rawValue));

  const Power._();

  /// Returns the energy in milli Watts
  int get milliWatts => rawValue;

  /// Returns the energy in Watts
  double get watts => rawValue / 1000;

  @override
  String toString() => '$rawValue mW';
}
