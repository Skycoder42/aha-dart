import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'right.freezed.dart';

enum AccessLevel {
  none,
  read,
  write,
}

@freezed
class Right with _$Right {
  const Right._();

  const factory Right.nas(AccessLevel access) = _Nas;
  const factory Right.app(AccessLevel access) = _App;
  const factory Right.homeAuto(AccessLevel access) = _HomeAuto;
  const factory Right.boxAdmin(AccessLevel access) = _BoxAdmin;
  const factory Right.phone(AccessLevel access) = _Phone;

  const factory Right.unknown({
    required String name,
    required AccessLevel access,
  }) = _Right;

  factory Right.fromXml(XmlElement nameElement, XmlElement accessElement) {
    assert(nameElement.name.toString() == 'Name');
    assert(accessElement.name.toString() == 'Access');

    final access = AccessLevel.values[int.parse(accessElement.text)];

    switch (nameElement.text) {
      case 'NAS':
        return Right.nas(access);
      case 'App':
        return Right.app(access);
      case 'HomeAuto':
        return Right.homeAuto(access);
      case 'BoxAdmin':
        return Right.boxAdmin(access);
      case 'Phone':
        return Right.phone(access);
      default:
        return Right.unknown(
          name: nameElement.text,
          access: access,
        );
    }
  }

  String get name => when(
        nas: (_) => 'NAS',
        app: (_) => 'App',
        homeAuto: (_) => 'HomeAuto',
        boxAdmin: (_) => 'BoxAdmin',
        phone: (_) => 'Phone',
        unknown: (name, _) => name,
      );

  void toXml(XmlBuilder builder) => builder
    ..element('Name', nest: name)
    ..element('Access', nest: access.index);
}
