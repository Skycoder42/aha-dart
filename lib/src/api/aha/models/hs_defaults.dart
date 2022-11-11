import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

import 'hs_color.dart';

part 'hs_defaults.freezed.dart';
part 'hs_defaults.g.dart';

/// A collection of default HSV based colors.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class HsDefaults with _$HsDefaults implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = HsDefaults();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_HsDefaultsXmlSerializableMixin')
  const factory HsDefaults({
    @xml.XmlElement(name: 'hs') @Default(<HsColor>[]) List<HsColor> hsColors,
  }) = _HsDefaults;

  /// @nodoc
  @internal
  factory HsDefaults.fromXmlElement(XmlElement element) =>
      _$_$_HsDefaultsFromXmlElement(element);
}
