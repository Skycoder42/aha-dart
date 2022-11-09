import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'stats.freezed.dart';
part 'stats.g.dart';

@internal
abstract class StatsUnit {}

abstract class StatsUnitCelsius implements StatsUnit {}

abstract class StatsUnitVolt implements StatsUnit {}

abstract class StatsUnitWatt implements StatsUnit {}

abstract class StatsUnitWattHours implements StatsUnit {}

abstract class StatsUnitPercent implements StatsUnit {}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Stats<TUnit extends StatsUnit>
    with _$Stats<TUnit>
    implements IXmlSerializable {
  static const _separatorValue = ',';
  static const _invalidValue = '-';

  static const invalid = Stats();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_StatsXmlSerializableMixin')
  const factory Stats({
    @xml.XmlAttribute() @Default(0) int count,
    @xml.XmlAttribute(name: 'grid')
    @visibleForOverriding
    @Default(0)
        int rawGrid,
    @xml.XmlText() @visibleForOverriding @Default('') String rawValues,
  }) = _Stats<TUnit>;

  factory Stats.fromXmlElement(XmlElement element) =>
      _$_$_StatsFromXmlElement(element).cast();

  const Stats._();

  Duration get grid => Duration(seconds: rawGrid);

  List<double> get values =>
      rawValues.split(_separatorValue).map(_parseElement).toList();

  double operator [](int index) => _parseElement<TUnit>(
        rawValues.split(_separatorValue).elementAt(index),
      );

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
