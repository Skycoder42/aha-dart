import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'stats.dart';

part 'stats_group.freezed.dart';
part 'stats_group.g.dart';

/// A group of statistics for a measurement.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class StatsGroup<TUnit extends StatsUnit>
    with _$StatsGroup<TUnit>
    implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = StatsGroup();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_StatsGroupXmlSerializableMixin')
  const factory StatsGroup({
    @xml.XmlElement() List<Stats<TUnit>>? stats,
  }) = _StatsGroup<TUnit>;

  /// @nodoc
  @internal
  factory StatsGroup.fromXmlElement(XmlElement element) =>
      _$_$_StatsGroupFromXmlElement(element).cast();

  const StatsGroup._();

  /// @nodoc
  @internal
  StatsGroup<TOtherUnit> cast<TOtherUnit extends StatsUnit>() =>
      StatsGroup<TOtherUnit>(
        stats: stats?.map((s) => s.cast<TOtherUnit>()).toList(),
      );
}
