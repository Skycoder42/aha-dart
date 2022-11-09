import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'switch_state.dart';

part 'switch.freezed.dart';
part 'switch.g.dart';

@xml.XmlEnum()
enum SwitchMode {
  manuell,
  auto,
}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Switch with _$Switch implements IXmlSerializable {
  static const invalid = Switch();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_SwitchXmlSerializableMixin')
  const factory Switch({
    @xml.XmlElement() @Default(SwitchState.invalid) SwitchState state,
    @xml.XmlElement() @Default(SwitchMode.manuell) SwitchMode mode,
    @xml.XmlElement() @Default(SwitchState.invalid) SwitchState lock,
    @xml.XmlElement(name: 'devicelock')
    @Default(SwitchState.invalid)
        SwitchState deviceLock,
  }) = _Switch;

  factory Switch.fromXmlElement(XmlElement element) =>
      _$_$_SwitchFromXmlElement(element);
}
