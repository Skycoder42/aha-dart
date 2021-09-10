import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

import '../../xml_typed_converter.dart';
import 'right.dart';
import 'user.dart';

part 'session_info.freezed.dart';

@freezed
class SessionInfo with _$SessionInfo {
  static const invalidSid = '0000000000000000';

  static const converter = _SessionInfoTypeConverter();

  const SessionInfo._();

  // ignore: sort_unnamed_constructors_first
  const factory SessionInfo({
    required String sid,
    required String challange,
    required int blockTime,
    required List<User> users,
    required List<Right> rights,
  }) = _SessionInfo;

  factory SessionInfo.fromXml(XmlElement element) {
    assert(element.name.toString() == 'SessionInfo');

    final rights =
        element.getElement('Rights')?.childElements.toList() ?? const [];
    assert(rights.length % 2 == 0, 'Rights must contain pairs of elements');

    final parsedRights = <Right>[];
    for (var i = 0; i < rights.length; i += 2) {
      final nameElement = rights[i];
      final accessElement = rights[i + 1];
      parsedRights.add(Right.fromXml(nameElement, accessElement));
    }

    return SessionInfo(
      sid: element.getElement('SID')!.text,
      challange: element.getElement('Challenge')!.text,
      blockTime: int.parse(element.getElement('BlockTime')!.text),
      users: List.unmodifiable(
        element
                .getElement('Users')
                ?.childElements
                .map((e) => User.fromXml(e)) ??
            const [],
      ),
      rights: List.unmodifiable(parsedRights),
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
        )
        ..element(
          'Rights',
          nest: () {
            for (final right in rights) {
              right.toXml(builder);
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
