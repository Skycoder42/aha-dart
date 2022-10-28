import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'timestamp.dart';

part 'button.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Button extends XmlEquatable<Button>
    with _$ButtonXmlSerializableMixin, _ButtonEquality {
  @xml.XmlAttribute()
  final int? id;

  @xml.XmlAttribute()
  final String? identifier;

  @xml.XmlElement(name: 'lastpressedtimestamp')
  final Timestamp lastPressedTimestamp;

  @xml.XmlElement()
  final String? name;

  const Button({
    required this.id,
    required this.identifier,
    required this.lastPressedTimestamp,
    required this.name,
  });

  factory Button.fromXmlElement(XmlElement element) =>
      _$ButtonFromXmlElement(element);
}

mixin _ButtonEquality on XmlEquatable<Button> {
  @override
  List<Object?> get props => [
        self.id,
        self.identifier,
        self.lastPressedTimestamp,
        self.name,
      ];
}
