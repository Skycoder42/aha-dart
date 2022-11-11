import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

import 'stats.dart';
import 'stats_group.dart';

part 'device_stats.freezed.dart';
part 'device_stats.g.dart';

/// A collection of measurement statistics for a given device.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class DeviceStats with _$DeviceStats implements IXmlConvertible {
  /// @nodoc
  @internal
  static const elementName = 'devicestats';

  /// @nodoc
  @internal
  static const invalid = DeviceStats();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: DeviceStats.elementName)
  @With.fromString(r'_$_$_DeviceStatsXmlSerializableMixin')
  const factory DeviceStats({
    @xml.XmlElement() StatsGroup<StatsUnitCelsius>? temperature,
    @xml.XmlElement() StatsGroup<StatsUnitPercent>? humidity,
    @xml.XmlElement() StatsGroup<StatsUnitVolt>? voltage,
    @xml.XmlElement() StatsGroup<StatsUnitWatt>? power,
    @xml.XmlElement() StatsGroup<StatsUnitWattHours>? energy,
  }) = _DeviceStats;

  /// @nodoc
  @internal
  factory DeviceStats.fromXmlElement(XmlElement element) =>
      _$_$_DeviceStatsFromXmlElement(element);
}
