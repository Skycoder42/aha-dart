import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'stats.dart';

part 'stats_group.freezed.dart';
part 'stats_group.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class StatsGroup<TUnit extends StatsUnit>
    with _$StatsGroup<TUnit>
    implements IXmlSerializable {
  static const invalid = StatsGroup();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_StatsGroupXmlSerializableMixin')
  const factory StatsGroup({
    @xml.XmlElement() List<Stats<TUnit>>? stats,
  }) = _StatsGroup<TUnit>;

  factory StatsGroup.fromXmlElement(XmlElement element) =>
      _$_$_StatsGroupFromXmlElement(element).cast();

  const StatsGroup._();

  StatsGroup<TOtherUnit> cast<TOtherUnit extends StatsUnit>() =>
      StatsGroup<TOtherUnit>(
        stats: stats?.map((s) => s.cast<TOtherUnit>()).toList(),
      );
}
