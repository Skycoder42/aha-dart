import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'sid.g.dart';

const _invalidSid = '0000000000000000';

@xml.XmlSerializable(createMixin: true)
@immutable
class Sid extends XmlEquatable<Sid>
    with _$SidXmlSerializableMixin, _SidEquality {
  @xml.XmlText()
  final String sid;

  const Sid({required this.sid})
      : assert(
          sid.length == 16,
          'must be a 64 bit hex encoded integer',
          // TODO use sid regex
        );

  const Sid.invalid() : sid = _invalidSid;

  factory Sid.fromXmlElement(XmlElement element) =>
      _$SidFromXmlElement(element);

  bool isValid() => sid != _invalidSid;
}

mixin _SidEquality on XmlEquatable<Sid> {
  @override
  @visibleForOverriding
  List<Object?> get props => [self.sid];
}
