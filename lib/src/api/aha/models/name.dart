import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'name.freezed.dart';
part 'name.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Name with _$Name implements IXmlSerializable {
  static const invalid = Name();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_NameXmlSerializableMixin')
  const factory Name({
    @xml.XmlAttribute(name: 'enum') int? enum_,
    @xml.XmlText() @Default('') String name,
  }) = _Name;

  factory Name.fromXmlElement(XmlElement element) =>
      _$_$_NameFromXmlElement(element);
}
