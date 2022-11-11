import 'package:meta/meta.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

part 'switch_state.g.dart';

/// The state of a switch device.
@xml.XmlEnum()
enum SwitchState {
  @xml.XmlValue('0')
  // ignore: public_member_api_docs
  off(false),
  @xml.XmlValue('1')
  // ignore: public_member_api_docs
  on(true),
  @xml.XmlValue('')
  // ignore: public_member_api_docs
  invalid(null);

  /// @nodoc
  @internal
  final bool? value;

  /// @nodoc
  @internal
  // ignore: avoid_positional_boolean_parameters
  const SwitchState(this.value);
}
