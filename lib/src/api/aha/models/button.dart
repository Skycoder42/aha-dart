import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'timestamp.dart';

part 'button.freezed.dart';
part 'button.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Button with _$Button implements IXmlSerializable {
  static const invalid = Button();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_ButtonXmlSerializableMixin')
  const factory Button({
    @xml.XmlAttribute() int? id,
    @xml.XmlAttribute() String? identifier,
    @xml.XmlElement(name: 'lastpressedtimestamp')
    @Default(Timestamp.deactivated)
        Timestamp lastPressedTimestamp,
    @xml.XmlElement() String? name,
  }) = _Button;

  factory Button.fromXmlElement(XmlElement element) =>
      _$_$_ButtonFromXmlElement(element);
}
