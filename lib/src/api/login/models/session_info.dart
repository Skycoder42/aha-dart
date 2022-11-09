import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'right.dart';
import 'sid.dart';
import 'user.dart';

part 'session_info.freezed.dart';
part 'session_info.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class SessionInfo with _$SessionInfo implements IXmlConvertible {
  static const elementName = 'SessionInfo';

  static const invalid = SessionInfo();

  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: SessionInfo.elementName)
  @With.fromString(r'_$_$_SessionInfoXmlSerializableMixin')
  const factory SessionInfo({
    @xml.XmlElement(name: 'SID') @Default(Sid.invalid) Sid sid,
    @xml.XmlElement(name: 'Challenge') @Default('') String challenge,
    @xml.XmlElement(name: 'BlockTime') @Default(0) int blockTime,
    @xml.XmlElement(name: 'Users') @Default(Users.empty) Users users,
    @xml.XmlElement(name: 'Rights')
    @Default(AccessRights.empty)
        AccessRights accessRights,
  }) = _SessionInfo;

  factory SessionInfo.fromXmlElement(XmlElement element) =>
      _$_$_SessionInfoFromXmlElement(element);
}
