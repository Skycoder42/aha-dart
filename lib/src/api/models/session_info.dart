import 'package:aha_client/src/api/xml_typed_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

import 'user.dart';

part 'session_info.freezed.dart';

@freezed
class SessionInfo with _$SessionInfo {
  static const invalidSid = '0000000000000000';

  static const converter = _SessionInfoTypeConverter();

  const SessionInfo._();

  const factory SessionInfo({
    required String sid,
    required String challange,
    required int blockTime,
    required List<User> users,
  }) = _SessionInfo;

  factory SessionInfo.fromXml(XmlElement element) {
    assert(element.name.toString() == 'SessionInfo');
    return SessionInfo(
      sid: element.getElement('SID')!.text,
      challange: element.getElement('Challenge')!.text,
      blockTime: int.parse(element.getElement('BlockTime')!.text),
      users: element
          .getElement('Users')!
          .childElements
          .map((e) => User.fromXml(e))
          .toList(),
    );
  }

  void toXml(XmlBuilder builder) {
    builder.element(
      'SessionInfo',
      nest: () => builder
        ..element('SID', nest: sid)
        ..element('Challange', nest: challange)
        ..element('BlockTime', nest: blockTime)
        ..element('Rights')
        ..element(
          'Users',
          nest: () {
            for (final user in users) {
              user.toXml(builder);
            }
          },
        ),
    );
  }
}

class _SessionInfoTypeConverter extends SimpleTypeConverter<SessionInfo> {
  const _SessionInfoTypeConverter();

  @override
  void buildXml(SessionInfo data, XmlBuilder builder) => data.toXml(builder);

  @override
  SessionInfo parseXml(XmlElement element) => SessionInfo.fromXml(element);
}
