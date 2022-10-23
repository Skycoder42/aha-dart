import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  // ignore: sort_unnamed_constructors_first
  const factory User(
    String user, {
    @Default(false) bool last,
  }) = _User;

  factory User.fromXml(XmlElement element) {
    assert(
      element.name.toString() == 'User',
      'element must be a <User> element.',
    );
    return User(
      element.text,
      last: element.getAttribute('last') == '1',
    );
  }

  void toXml(XmlBuilder builder) {
    builder.element(
      'User',
      attributes: {
        if (last) 'last': '1',
      },
      nest: user,
    );
  }
}
