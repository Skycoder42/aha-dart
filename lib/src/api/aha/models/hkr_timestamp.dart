import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'hkr_timestamp.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class HkrTimestamp extends XmlEquatable<HkrTimestamp>
    with _$HkrTimestampXmlSerializableMixin, _HkrTimestampEquality {
  @xml.XmlText()
  @visibleForTesting
  final int rawValue;

  const HkrTimestamp({
    required this.rawValue,
  });

  factory HkrTimestamp.fromXmlElement(XmlElement element) =>
      _$HkrTimestampFromXmlElement(element);

  DateTime? getValue() => rawValue > 0
      ? DateTime.fromMillisecondsSinceEpoch(rawValue * 1000)
      : null;

  @override
  String toString() => getValue().toString();
}

mixin _HkrTimestampEquality on XmlEquatable<HkrTimestamp> {
  @override
  List<Object?> get props => [self.getValue()];
}
