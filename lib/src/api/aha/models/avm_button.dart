import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'percentage.dart';

part 'avm_button.freezed.dart';
part 'avm_button.g.dart';

/// Status information about an avm button device
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class AvmButton with _$AvmButton implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = AvmButton();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_AvmButtonXmlSerializableMixin')
  const factory AvmButton({
    @xml.XmlElement() @Default(Percentage.invalid) Percentage humidity,
  }) = _AvmButton;

  /// @nodoc
  @internal
  factory AvmButton.fromXmlElement(XmlElement element) =>
      _$_$_AvmButtonFromXmlElement(element);
}
