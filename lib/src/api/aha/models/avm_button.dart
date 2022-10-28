import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'percentage.dart';

part 'avm_button.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class AvmButton extends XmlEquatable<AvmButton>
    with _$AvmButtonXmlSerializableMixin, _AvmButtonEquality {
  @xml.XmlElement()
  final OptionalPercentage humidity;

  const AvmButton({
    required this.humidity,
  });

  factory AvmButton.fromXmlElement(XmlElement element) =>
      _$AvmButtonFromXmlElement(element);
}

mixin _AvmButtonEquality on XmlEquatable<AvmButton> {
  @override
  List<Object?> get props => [
        self.humidity,
      ];
}
