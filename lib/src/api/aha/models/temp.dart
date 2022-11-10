import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'temp.freezed.dart';
part 'temp.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Temp with _$Temp implements IXmlSerializable {
  static const invalid = Temp();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_TempXmlSerializableMixin')
  const factory Temp({
    @xml.XmlAttribute() @Default(0) int value,
  }) = _Temp;

  factory Temp.fromXmlElement(XmlElement element) =>
      _$_$_TempFromXmlElement(element);
}
