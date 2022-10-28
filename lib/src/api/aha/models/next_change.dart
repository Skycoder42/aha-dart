import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'hkr_temperature.dart';
import 'timestamp.dart';

part 'next_change.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class NextChange extends XmlEquatable<NextChange>
    with _$NextChangeXmlSerializableMixin, _NextChangeEquality {
  @xml.XmlElement(name: 'endperiod')
  final Timestamp endPeriod;

  @xml.XmlElement(name: 'tchange')
  final HkrTemperatur tChange;

  const NextChange({
    required this.endPeriod,
    required this.tChange,
  });

  factory NextChange.fromXmlElement(XmlElement element) =>
      _$NextChangeFromXmlElement(element);
}

mixin _NextChangeEquality on XmlEquatable<NextChange> {
  @override
  List<Object?> get props => [
        self.endPeriod,
        self.tChange,
      ];
}
