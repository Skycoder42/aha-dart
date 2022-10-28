import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'simple_on_off.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class SimpleOnOff extends XmlEquatable<SimpleOnOff>
    with _$SimpleOnOffXmlSerializableMixin, _SimpleOnOffEquality {
  @xml.XmlElement()
  final bool state;

  const SimpleOnOff({
    required this.state,
  });

  factory SimpleOnOff.fromXmlElement(XmlElement element) =>
      _$SimpleOnOffFromXmlElement(element);
}

mixin _SimpleOnOffEquality on XmlEquatable<SimpleOnOff> {
  @override
  List<Object?> get props => [
        self.state,
      ];
}
