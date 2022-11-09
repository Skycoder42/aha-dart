import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'timestamp.dart';

part 'alert.freezed.dart';
part 'alert.g.dart';

@xml.XmlEnum()
enum AlertState {
  @xml.XmlValue('0')
  ok(false),
  @xml.XmlValue('1')
  alertOrBlocked(true),
  @xml.XmlValue('2')
  overheated(true),
  @xml.XmlValue('3')
  blockedAndOverheated(true),
  @xml.XmlValue('')
  unknown(null);

  final bool? hasAlert;

  // ignore: avoid_positional_boolean_parameters
  const AlertState(this.hasAlert);
}

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Alert with _$Alert implements IXmlSerializable {
  static const invalid = Alert();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_AlertXmlSerializableMixin')
  const factory Alert({
    @xml.XmlElement() @Default(AlertState.unknown) AlertState state,
    @xml.XmlElement(name: 'lastalertchgtimestamp')
    @Default(Timestamp.invalid)
        Timestamp lastAlertChgTimestamp,
  }) = _Alert;

  factory Alert.fromXmlElement(XmlElement element) =>
      _$_$_AlertFromXmlElement(element);
}
