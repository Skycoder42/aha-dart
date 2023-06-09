import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'timestamp.dart';

part 'alert.freezed.dart';
part 'alert.g.dart';

/// The state of an alert device.
///
/// {@macro aha_reference}
@xml.XmlEnum()
enum AlertState {
  @xml.XmlValue('0')
  // ignore: public_member_api_docs
  ok(false),

  @xml.XmlValue('1')
  // ignore: public_member_api_docs
  alertOrBlocked(true),

  @xml.XmlValue('2')
  // ignore: public_member_api_docs
  overheated(true),

  @xml.XmlValue('3')
  // ignore: public_member_api_docs
  blockedAndOverheated(true),

  @xml.XmlValue('')
  // ignore: public_member_api_docs
  unknown(null);

  /// Checks if the current value is an alert or not.
  ///
  /// Can be null if the alert state is unknown.
  final bool? hasAlert;

  /// @nodoc
  @internal
  // ignore: avoid_positional_boolean_parameters
  const AlertState(this.hasAlert);
}

/// Status information about an alert device
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Alert with _$Alert implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = Alert();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_AlertXmlSerializableMixin')
  const factory Alert({
    @xml.XmlElement() @Default(AlertState.unknown) AlertState state,
    @xml.XmlElement(name: 'lastalertchgtimestamp')
    @Default(Timestamp.deactivated)
    Timestamp lastAlertChgTimestamp,
  }) = _Alert;

  /// @nodoc
  @internal
  factory Alert.fromXmlElement(XmlElement element) =>
      _$_$_AlertFromXmlElement(element);
}
