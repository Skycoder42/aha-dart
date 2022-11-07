import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'simple_on_off.freezed.dart';
part 'simple_on_off.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class SimpleOnOff with _$SimpleOnOff implements IXmlSerializable {
  static const off = SimpleOnOff();
  static const on = SimpleOnOff(state: true);

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_SimpleOnOffXmlSerializableMixin')
  const factory SimpleOnOff({
    @xml.XmlElement() @Default(false) bool state,
  }) = _SimpleOnOff;

  factory SimpleOnOff.fromXmlElement(XmlElement element) =>
      _$_$_SimpleOnOffFromXmlElement(element);
}
