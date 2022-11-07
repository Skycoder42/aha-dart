import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class User with _$User implements IXmlSerializable {
  static const invalid = User();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_UserXmlSerializableMixin')
  const factory User({
    @xml.XmlText() @Default('') String user,
    @xml.XmlAttribute() @Default(false) bool? last,
  }) = _User;

  factory User.fromXmlElement(XmlElement element) =>
      _$_$_UserFromXmlElement(element);
}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Users with _$Users implements IXmlSerializable {
  static const empty = Users();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_UsersXmlSerializableMixin')
  const factory Users({
    @xml.XmlElement() @Default(<User>[]) List<User>? users,
  }) = _Users;

  factory Users.fromXmlElement(XmlElement element) =>
      _$_$_UsersFromXmlElement(element);
}
