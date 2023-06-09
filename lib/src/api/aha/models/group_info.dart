import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'group_info.freezed.dart';
part 'group_info.g.dart';

/// Information about the devices in a device group.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class GroupInfo with _$GroupInfo implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = GroupInfo();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_GroupInfoXmlSerializableMixin')
  const factory GroupInfo({
    @xml.XmlElement(name: 'masterdeviceid') @Default(0) int masterDeviceId,

    /// @nodoc
    @xml.XmlElement(name: 'members')
    @visibleForOverriding
    @Default('')
    String rawMembers,
  }) = _GroupInfo;

  /// @nodoc
  @internal
  factory GroupInfo.fromXmlElement(XmlElement element) =>
      _$_$_GroupInfoFromXmlElement(element);

  const GroupInfo._();

  // ignore: public_member_api_docs
  List<int> get members => rawMembers.split(',').map(int.parse).toList();
}
