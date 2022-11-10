import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'group_info.freezed.dart';
part 'group_info.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class GroupInfo with _$GroupInfo implements IXmlSerializable {
  static const invalid = GroupInfo();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_GroupInfoXmlSerializableMixin')
  const factory GroupInfo({
    @xml.XmlElement(name: 'masterdeviceid') @Default(0) int masterDeviceId,
    @xml.XmlElement(name: 'members')
    @visibleForOverriding
    @Default('')
        String rawMembers,
  }) = _GroupInfo;

  factory GroupInfo.fromXmlElement(XmlElement element) =>
      _$_$_GroupInfoFromXmlElement(element);

  const GroupInfo._();

  List<int> get members => rawMembers.split(',').map(int.parse).toList();
}
