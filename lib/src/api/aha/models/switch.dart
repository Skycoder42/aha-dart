import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'switch_state.dart';

part 'switch.freezed.dart';
part 'switch.g.dart';

/// The mode of the switch.
@xml.XmlEnum()
enum SwitchMode {
  // ignore: public_member_api_docs
  manuell,
  // ignore: public_member_api_docs
  auto,
}

/// The configuration of a switch device.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Switch with _$Switch implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = Switch();

  /// @nodoc
  @internal
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

  /// @nodoc
  @internal
  factory Switch.fromXmlElement(XmlElement element) =>
      _$_$_SwitchFromXmlElement(element);
}
