import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'timestamp.freezed.dart';
part 'timestamp.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Timestamp with _$Timestamp implements IXmlSerializable {
  static const deactivated = Timestamp();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_TimestampXmlSerializableMixin')
  const factory Timestamp({
    @xml.XmlText() @Default('0') @visibleForOverriding String rawValue,
  }) = _Timestamp;

  factory Timestamp.fromXmlElement(XmlElement element) =>
      _$_$_TimestampFromXmlElement(element);

  factory Timestamp.fromDateTime(DateTime dateTime, {DateTime? now}) {
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

  factory Timestamp.fromString(String rawValue) =>
      Timestamp(rawValue: rawValue);

  const Timestamp._();

  Duration? get epochOffset {
    final secondsSinceEpoch = int.tryParse(rawValue, radix: 10) ?? 0;
    return secondsSinceEpoch > 0 ? Duration(seconds: secondsSinceEpoch) : null;
  }

  DateTime? get localTime {
    final offset = epochOffset;
    return offset != null
        ? DateTime.fromMillisecondsSinceEpoch(offset.inMilliseconds)
        : null;
  }

  DateTime? get utc {
    final offset = epochOffset;
    return offset != null
        ? DateTime.fromMillisecondsSinceEpoch(
            offset.inMilliseconds,
            isUtc: true,
          )
        : null;
  }

  bool get isActive => epochOffset != null;

  @override
  String toString({bool pretty = false}) =>
      pretty ? localTime.toString() : rawValue;
}
