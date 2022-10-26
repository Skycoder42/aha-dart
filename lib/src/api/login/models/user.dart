import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'user.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class User extends XmlEquatable<User>
    with _$UserXmlSerializableMixin, _UserEquality {
  @xml.XmlText()
  final String user;

  @xml.XmlAttribute()
  final bool? last;

  const User({
    required this.user,
    this.last = false,
  });

  factory User.fromXmlElement(XmlElement element) =>
      _$UserFromXmlElement(element);
}

mixin _UserEquality on XmlEquatable<User> {
  @override
  @visibleForOverriding
  List<Object?> get props => [self.user, self.last];
}

@xml.XmlSerializable(createMixin: true)
@immutable
class Users extends XmlEquatable<Users>
    with _$UsersXmlSerializableMixin, _UsersEquality {
  @xml.XmlElement(name: 'User')
  final List<User> users;

  const Users({
    required this.users,
  });

  factory Users.fromXmlElement(XmlElement element) =>
      _$UsersFromXmlElement(element);
}

mixin _UsersEquality on XmlEquatable<Users> {
  @override
  @visibleForOverriding
  List<Object?> get props => [self.users];
}
