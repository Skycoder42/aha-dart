import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

import 'stats.dart';
import 'stats_group.dart';

part 'device_stats.freezed.dart';
part 'device_stats.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class DeviceStats with _$DeviceStats implements IXmlConvertible {
  static const elementName = 'devicestats';

  static const invalid = DeviceStats();

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

  factory DeviceStats.fromXmlElement(XmlElement element) =>
      _$_$_DeviceStatsFromXmlElement(element);
}
