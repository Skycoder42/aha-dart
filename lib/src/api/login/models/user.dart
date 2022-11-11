import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// A user that can login to the fritz.box
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class User with _$User implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = User();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_UserXmlSerializableMixin')
  const factory User({
    @xml.XmlText() @Default('') String user,

    /// @nodoc
    @visibleForOverriding
    @xml.XmlAttribute(name: 'last')
    @Default(false)
        bool? lastRaw,
  }) = _User;

  /// @nodoc
  @internal
  factory User.fromXmlElement(XmlElement element) =>
      _$_$_UserFromXmlElement(element);

  const User._();

  // ignore: public_member_api_docs
  bool get last => lastRaw ?? false;
}

/// A list of users that can login on the fritz.box
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Users with _$Users implements IXmlSerializable {
  /// @nodoc
  @internal
  static const empty = Users();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_UsersXmlSerializableMixin')
  const factory Users({
    @xml.XmlElement() @Default(<User>[]) List<User>? users,
  }) = _Users;

  /// @nodoc
  @internal
  factory Users.fromXmlElement(XmlElement element) =>
      _$_$_UsersFromXmlElement(element);
}
