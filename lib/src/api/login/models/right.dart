import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'right.freezed.dart';
part 'right.g.dart';

@xml.XmlEnum()
enum AccessName {
  @xml.XmlValue('NAS')
  nas,
  @xml.XmlValue('App')
  app,
  @xml.XmlValue('HomeAuto')
  homeAuto,
  @xml.XmlValue('BoxAdmin')
  boxAdmin,
  @xml.XmlValue('Phone')
  phone;
}

@xml.XmlEnum()
enum AccessLevel {
  @xml.XmlValue('0')
  none,
  @xml.XmlValue('1')
  read,
  @xml.XmlValue('2')
  write,
}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class AccessRights with _$AccessRights implements IXmlSerializable {
  static const empty = AccessRights();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_AccessRightsXmlSerializableMixin')
  const factory AccessRights({
    @xml.XmlElement(name: 'Name') @visibleForOverriding List<AccessName>? names,
    @xml.XmlElement(name: 'Access')
    @visibleForOverriding
        List<AccessLevel>? accesses,
  }) = _AccessRights;

  const AccessRights._();

  factory AccessRights.fromXmlElement(XmlElement element) =>
      _$_$_AccessRightsFromXmlElement(element);

  AccessLevel getAccessLevelFor(AccessName accessName) {
    assert(
      names?.length == accesses?.length,
      'names and accesses must have equal lengths',
    );
    final nameIndex = names?.indexOf(accessName) ?? -1;
    if (nameIndex < 0) {
      return AccessLevel.none;
    } else {
      return accesses?[nameIndex] ?? AccessLevel.none;
    }
  }
}
