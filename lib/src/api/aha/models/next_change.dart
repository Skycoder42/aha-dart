import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'hkr_temperature.dart';
import 'timestamp.dart';

part 'next_change.freezed.dart';
part 'next_change.g.dart';

/// A scheduled change of temperature of a thermostat.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class NextChange with _$NextChange implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = NextChange();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_NextChangeXmlSerializableMixin')
  const factory NextChange({
    @xml.XmlElement(name: 'endperiod')
    @Default(Timestamp.deactivated)
    Timestamp endPeriod,
    @xml.XmlElement(name: 'tchange')
    @Default(HkrTemperature.invalid)
    HkrTemperature tChange,
  }) = _NextChange;

  /// @nodoc
  @internal
  factory NextChange.fromXmlElement(XmlElement element) =>
      _$_$_NextChangeFromXmlElement(element);
}
