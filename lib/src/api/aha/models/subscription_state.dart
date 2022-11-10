import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';

part 'subscription_state.freezed.dart';
part 'subscription_state.g.dart';

@xml.XmlEnum()
enum SubscriptionState {
  @xml.XmlValue('0')
  registrationNotRunning,
  @xml.XmlValue('1')
  registrationRunning,
  @xml.XmlValue('2')
  timeout,
  @xml.XmlValue('3')
  error,
}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class State with _$State implements IXmlConvertible {
  static const elementName = 'state';

  static const invalid = State();

  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: State.elementName)
  @With.fromString(r'_$_$_StateXmlSerializableMixin')
  const factory State({
    @xml.XmlAttribute()
    @Default(SubscriptionState.registrationNotRunning)
        SubscriptionState code,
    @xml.XmlElement(name: 'latestain') String? latestAin,
  }) = _State;

  factory State.fromXmlElement(XmlElement element) =>
      _$_$_StateFromXmlElement(element);
}
