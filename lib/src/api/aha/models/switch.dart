import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'switch_state.dart';

part 'switch.g.dart';

enum SwitchMode {
  auto,
  manuell,
}

@xml.XmlSerializable(createMixin: true)
@immutable
class Switch extends XmlEquatable<Switch>
    with _$SwitchXmlSerializableMixin, _SwitchEquality {
  @xml.XmlElement()
  final SwitchState state;

  @xml.XmlElement()
  final SwitchMode mode;

  @xml.XmlElement()
  final SwitchState lock;

  @xml.XmlElement(name: 'devicelock')
  final SwitchState deviceLock;

  const Switch({
    required this.state,
    required this.mode,
    required this.lock,
    required this.deviceLock,
  });

  factory Switch.fromXmlElement(XmlElement element) =>
      _$SwitchFromXmlElement(element);
}

mixin _SwitchEquality on XmlEquatable<Switch> {
  @override
  List<Object?> get props => [
        self.state,
        self.mode,
        self.lock,
        self.deviceLock,
      ];
}
