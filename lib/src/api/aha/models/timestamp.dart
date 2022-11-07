import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'timestamp.freezed.dart';
part 'timestamp.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Timestamp with _$Timestamp implements IXmlSerializable {
  static const invalid = Timestamp();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_TimestampXmlSerializableMixin')
  const factory Timestamp({
    @xml.XmlText() @Default('0') @visibleForTesting String rawValue,
  }) = _Timestamp;

  factory Timestamp.fromXmlElement(XmlElement element) =>
      _$_$_TimestampFromXmlElement(element);

  const Timestamp._();

  DateTime? get value {
    final secondsSinceEpoche = int.tryParse(rawValue, radix: 10) ?? 0;
    return secondsSinceEpoche > 0
        ? DateTime.fromMillisecondsSinceEpoch(
            secondsSinceEpoche * 1000,
            isUtc: true,
          )
        : null;
  }

  @override
  String toString() => value.toString();
}
