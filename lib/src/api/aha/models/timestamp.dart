import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'timestamp.freezed.dart';
part 'timestamp.g.dart';

/// A timestamp for an event.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Timestamp with _$Timestamp implements IXmlSerializable {
  /// A deactivated timestamp, meaning that no event is planned or to deactivate
  /// a planned event.
  static const deactivated = Timestamp();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_TimestampXmlSerializableMixin')
  const factory Timestamp({
    @xml.XmlText() @Default('0') @visibleForOverriding String rawValue,
  }) = _Timestamp;

  /// @nodoc
  @internal
  factory Timestamp.fromXmlElement(XmlElement element) =>
      _$_$_TimestampFromXmlElement(element);

  /// @nodoc
  @internal
  factory Timestamp.fromString(String rawValue) =>
      Timestamp(rawValue: rawValue);

  /// Creates a new timestamp from a [dateTime] value.
  ///
  /// The [dateTime] must not be in the past and not further in the future then
  /// 24 hours.
  ///
  /// By default, [DateTime.now] is used to calculate if the [dateTime] is
  /// valid. For testing purposes, that can be overwritten with [now].
  factory Timestamp.create(DateTime dateTime, {DateTime? now}) {
    final actualNow = now ?? DateTime.now();
    if (dateTime.isBefore(actualNow) ||
        dateTime.isAfter(actualNow.add(const Duration(days: 1)))) {
      throw ArgumentError.value(
        dateTime,
        'dateTime',
        'Must not be in the past and at most 24 hours in the future '
            '(now: $actualNow)',
      );
    }

    return Timestamp(
      rawValue: Duration(milliseconds: dateTime.millisecondsSinceEpoch)
          .inSeconds
          .toString(),
    );
  }

  const Timestamp._();

  /// The offset since the epoch start (1970-01-01).
  ///
  /// Can be null if no timestamp is set.
  Duration? get epochOffset {
    final secondsSinceEpoch = int.tryParse(rawValue, radix: 10) ?? 0;
    return secondsSinceEpoch > 0 ? Duration(seconds: secondsSinceEpoch) : null;
  }

  /// The point in time of this timestamp as local time.
  DateTime? get localTime {
    final offset = epochOffset;
    return offset != null
        ? DateTime.fromMillisecondsSinceEpoch(offset.inMilliseconds)
        : null;
  }

  /// The point in time of this timestamp as UTC time.
  DateTime? get utc {
    final offset = epochOffset;
    return offset != null
        ? DateTime.fromMillisecondsSinceEpoch(
            offset.inMilliseconds,
            isUtc: true,
          )
        : null;
  }

  /// Checks if this timestamp is active or [deactivated].
  bool get isActive => epochOffset != null;

  @override
  String toString({bool pretty = false}) =>
      pretty ? localTime.toString() : rawValue;
}
