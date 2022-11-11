import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'subscription_state.freezed.dart';
part 'subscription_state.g.dart';

/// The state of the device registration.
@xml.XmlEnum()
enum SubscriptionState {
  @xml.XmlValue('0')
  // ignore: public_member_api_docs
  registrationNotRunning,
  @xml.XmlValue('1')
  // ignore: public_member_api_docs
  registrationRunning,
  @xml.XmlValue('2')
  // ignore: public_member_api_docs
  timeout,
  @xml.XmlValue('3')
  // ignore: public_member_api_docs
  error,
}

/// The state of the BLE registration.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class State with _$State implements IXmlConvertible {
  /// @nodoc
  @internal
  static const elementName = 'state';

  /// @nodoc
  @internal
  static const invalid = State();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: State.elementName)
  @With.fromString(r'_$_$_StateXmlSerializableMixin')
  const factory State({
    @xml.XmlAttribute()
    @Default(SubscriptionState.registrationNotRunning)
        SubscriptionState code,
    @xml.XmlElement(name: 'latestain') String? latestAin,
  }) = _State;

  /// @nodoc
  @internal
  factory State.fromXmlElement(XmlElement element) =>
      _$_$_StateFromXmlElement(element);
}
