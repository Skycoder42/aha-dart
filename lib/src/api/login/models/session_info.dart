import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'right.dart';
import 'sid.dart';
import 'user.dart';

part 'session_info.g.dart';

const sessionInfoElementName = 'SessionInfo';

@xml.XmlSerializable(createMixin: true)
@xml.XmlRootElement(name: sessionInfoElementName)
@immutable
class SessionInfo extends XmlConvertible<SessionInfo>
    with _$SessionInfoXmlSerializableMixin, _SessionInfoEquality {
  @xml.XmlElement(name: 'SID')
  final Sid sid;

  @xml.XmlElement(name: 'Challenge')
  final String challenge;

  @xml.XmlElement(name: 'BlockTime')
  final int blockTime;

  @xml.XmlElement(name: 'Users')
  final Users users;

  @xml.XmlElement(name: 'Rights')
  final AccessRights accessRights;

  const SessionInfo({
    required this.sid,
    required this.challenge,
    required this.blockTime,
    required this.users,
    required this.accessRights,
  });

  factory SessionInfo.fromXmlElement(XmlElement element) =>
      _$SessionInfoFromXmlElement(element);
}

mixin _SessionInfoEquality on XmlConvertible<SessionInfo> {
  @override
  @visibleForOverriding
  List<Object?> get props => [
        self.sid,
        self.challenge,
        self.blockTime,
        self.users,
        self.accessRights,
      ];
}
