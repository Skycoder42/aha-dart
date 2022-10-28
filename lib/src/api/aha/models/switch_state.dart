import 'package:xml_annotation/xml_annotation.dart' as xml;

part 'switch_state.g.dart';

@xml.XmlEnum()
enum SwitchState {
  @xml.XmlValue('0')
  off(false),
  @xml.XmlValue('1')
  on(true),
  @xml.XmlValue('')
  invalid(null);

  final bool? value;

  // ignore: avoid_positional_boolean_parameters
  const SwitchState(this.value);
}
