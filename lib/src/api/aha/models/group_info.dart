import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'group_info.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class GroupInfo extends XmlEquatable<GroupInfo>
    with _$GroupInfoXmlSerializableMixin, _GroupInfoEquality {
  @xml.XmlElement(name: 'masterdeviceid')
  final int masterDeviceId;

  @xml.XmlElement()
  @visibleForTesting
  final String members;

  const GroupInfo({
    required this.masterDeviceId,
    required this.members,
  });

  factory GroupInfo.fromXmlElement(XmlElement element) =>
      _$GroupInfoFromXmlElement(element);

  List<int> getMembers() => members.split(',').map(int.parse).toList();
}

mixin _GroupInfoEquality on XmlEquatable<GroupInfo> {
  @override
  List<Object?> get props => [
        self.masterDeviceId,
      ];
}
