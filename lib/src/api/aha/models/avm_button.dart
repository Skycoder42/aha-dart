import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'percentage.dart';

part 'avm_button.freezed.dart';
part 'avm_button.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class AvmButton with _$AvmButton implements IXmlSerializable {
  static const invalid = AvmButton();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_AvmButtonXmlSerializableMixin')
  const factory AvmButton({
    @xml.XmlElement() @Default(Percentage.invalid) Percentage humidity,
  }) = _AvmButton;

  factory AvmButton.fromXmlElement(XmlElement element) =>
      _$_$_AvmButtonFromXmlElement(element);
}
