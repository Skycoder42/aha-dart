import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'timestamp.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Timestamp extends XmlEquatable<Timestamp>
    with _$TimestampXmlSerializableMixin, _TimestampEquality {
  @xml.XmlText()
  @visibleForTesting
  final String rawValue;

  const Timestamp({
    required this.rawValue,
  });

  factory Timestamp.fromXmlElement(XmlElement element) =>
      _$TimestampFromXmlElement(element);

  DateTime? getLocalTime() {
    final secondsSinceEpoche = _getSecondsSinceEpoche();
    return secondsSinceEpoche > 0
        ? DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoche * 1000)
        : null;
  }

  @override
  String toString() => getLocalTime().toString();

  int _getSecondsSinceEpoche() => int.tryParse(rawValue, radix: 10) ?? 0;
}

mixin _TimestampEquality on XmlEquatable<Timestamp> {
  @override
  List<Object?> get props => [self.getLocalTime()];
}
