import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'sid.freezed.dart';
part 'sid.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Sid with _$Sid implements IXmlSerializable {
  static const _invalidValue = '0000000000000000';

  static const invalid = Sid();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_SidXmlSerializableMixin')
  @Assert('sid.length == 16', 'must be a 64 bit hex encoded integer')
  const factory Sid({
    @xml.XmlText() @Default(Sid._invalidValue) String sid,
  }) = _Sid;

  const Sid._();

  factory Sid.fromXmlElement(XmlElement element) =>
      _$_$_SidFromXmlElement(element);

  bool get isValid => sid != _invalidValue;
}
