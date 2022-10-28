import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'timestamp.dart';

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

@xml.XmlSerializable(createMixin: true)
@immutable
class Alert extends XmlEquatable<Alert>
    with _$AlertXmlSerializableMixin, _AlertEquality {
  @xml.XmlElement()
  final AlertState state;

  @xml.XmlElement(name: 'lastalertchgtimestamp')
  final Timestamp lastAlertChgTimestamp;

  const Alert({
    required this.state,
    required this.lastAlertChgTimestamp,
  });

  factory Alert.fromXmlElement(XmlElement element) =>
      _$AlertFromXmlElement(element);
}

mixin _AlertEquality on XmlEquatable<Alert> {
  @override
  List<Object?> get props => [
        self.state,
        self.lastAlertChgTimestamp,
      ];
}
