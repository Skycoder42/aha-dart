import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

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

@xml.XmlSerializable(createMixin: true)
@immutable
class AccessRights extends XmlEquatable<AccessRights>
    with _$AccessRightsXmlSerializableMixin, _AccessRightsEquality {
  @xml.XmlElement(name: 'Name')
  final List<AccessName>? names;

  @xml.XmlElement(name: 'Access')
  final List<AccessLevel>? accesses;

  const AccessRights({
    required this.names,
    required this.accesses,
  }) : assert(
          names?.length == accesses?.length,
          'names and accesses must have equal lengths',
        );

  const AccessRights.empty()
      : names = null,
        accesses = null;

  factory AccessRights.fromXmlElement(XmlElement element) =>
      _$AccessRightsFromXmlElement(element);

  AccessLevel getAccessLevelFor(AccessName accessName) {
    final nameIndex = names?.indexOf(accessName) ?? -1;
    if (nameIndex < 0) {
      return AccessLevel.none;
    } else {
      return accesses?[nameIndex] ?? AccessLevel.none;
    }
  }
}

mixin _AccessRightsEquality on XmlEquatable<AccessRights> {
  @override
  @visibleForOverriding
  List<Object?> get props => [self.names, self.accesses];
}
