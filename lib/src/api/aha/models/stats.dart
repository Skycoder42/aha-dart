import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'stats.freezed.dart';
part 'stats.g.dart';

/// @nodoc
@internal
abstract class StatsUnit {}

/// Indicates that the measurements are celsius values.
abstract class StatsUnitCelsius implements StatsUnit {}

/// Indicates that the measurements are Volt values.
abstract class StatsUnitVolt implements StatsUnit {}

/// Indicates that the measurements are Watt values.
abstract class StatsUnitWatt implements StatsUnit {}

/// Indicates that the measurements are Watt hour values.
abstract class StatsUnitWattHours implements StatsUnit {}

/// Indicates that the measurements are percentage values.
abstract class StatsUnitPercent implements StatsUnit {}

/// A statistics for a measurement.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Stats<TUnit extends StatsUnit>
    with _$Stats<TUnit>
    implements IXmlSerializable {
  static const _separatorValue = ',';
  static const _invalidValue = '-';

  /// @nodoc
  @internal
  static const invalid = Stats();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_StatsXmlSerializableMixin')
  const factory Stats({
    @xml.XmlAttribute() @Default(0) int count,

    /// @nodoc
    @xml.XmlAttribute(name: 'grid')
    @visibleForOverriding
    @Default(0)
        int rawGrid,

    /// @nodoc
    @xml.XmlText() @visibleForOverriding @Default('') String rawValues,
  }) = _Stats<TUnit>;

  /// @nodoc
  @internal
  factory Stats.fromXmlElement(XmlElement element) =>
      _$_$_StatsFromXmlElement(element).cast();

  const Stats._();

  // ignore: public_member_api_docs
  Duration get grid => Duration(seconds: rawGrid);

  // ignore: public_member_api_docs
  List<double> get values =>
      rawValues.split(_separatorValue).map(_parseElement).toList();

  /// Returns the value at the given [index].
  double operator [](int index) => _parseElement<TUnit>(
        rawValues.split(_separatorValue).elementAt(index),
      );

  /// @nodoc
  @internal
  Stats<TOtherUnit> cast<TOtherUnit extends StatsUnit>() => Stats<TOtherUnit>(
        count: count,
        rawGrid: rawGrid,
        rawValues: rawValues,
      );

  static double _parseElement<TUnit extends StatsUnit>(String value) {
    final intValue = value == _invalidValue ? null : int.parse(value);
    if (intValue == null) {
      return double.nan;
    }

    switch (TUnit) {
      case StatsUnitCelsius:
        return intValue / 10;
      case StatsUnitVolt:
        return intValue / 1000;
      case StatsUnitWatt:
        return intValue / 100;
      case StatsUnitWattHours:
        return intValue.toDouble();
      case StatsUnitPercent:
        return intValue / 100;
      default:
        throw StateError('Unknown unit type $TUnit');
    }
  }
}
