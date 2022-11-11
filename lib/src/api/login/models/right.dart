import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'right.freezed.dart';
part 'right.g.dart';

/// The different access types a user can have
///
/// {@macro aha_reference}
@xml.XmlEnum()
enum AccessType {
  /// Can access the NAS
  @xml.XmlValue('NAS')
  nas,

  /// Can access the Apps
  @xml.XmlValue('App')
  app,

  /// Can access and configure the AHA
  @xml.XmlValue('HomeAuto')
  homeAuto,

  /// Is administrator
  @xml.XmlValue('BoxAdmin')
  boxAdmin,

  /// Can use the SIP APIs
  @xml.XmlValue('Phone')
  phone;
}

/// The different access levels a user can have for a [AccessType]
///
/// {@macro aha_reference}
@xml.XmlEnum()
enum AccessLevel {
  /// No access
  @xml.XmlValue('0')
  none,

  /// Read-only access
  @xml.XmlValue('1')
  read,

  /// Read-Write access
  @xml.XmlValue('2')
  write,
}

/// The different access types and levels the current user has access to.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class AccessRights with _$AccessRights implements IXmlSerializable {
  /// @nodoc
  @internal
  static const empty = AccessRights();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_AccessRightsXmlSerializableMixin')
  const factory AccessRights({
    /// @nodoc
    @visibleForOverriding @xml.XmlElement(name: 'Name') List<AccessType>? names,

    /// @nodoc
    @visibleForOverriding
    @xml.XmlElement(name: 'Access')
        List<AccessLevel>? accesses,
  }) = _AccessRights;

  /// @nodoc
  @internal
  factory AccessRights.fromXmlElement(XmlElement element) =>
      _$_$_AccessRightsFromXmlElement(element);

  const AccessRights._();

  /// Get the [AccessLevel] for the given [accessType].
  ///
  /// If the type is not know, [AccessLevel.none] is returned.
  AccessLevel getAccessLevelFor(AccessType accessType) {
    assert(
      names?.length == accesses?.length,
      'names and accesses must have equal lengths',
    );
    final nameIndex = names?.indexOf(accessType) ?? -1;
    if (nameIndex < 0) {
      return AccessLevel.none;
    } else {
      return accesses?[nameIndex] ?? AccessLevel.none;
    }
  }
}
