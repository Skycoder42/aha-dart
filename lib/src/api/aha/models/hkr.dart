import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'battery_percentage.dart';
import 'hkr_temperature.dart';
import 'hkr_timestamp.dart';
import 'next_change.dart';

part 'hkr.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Hkr extends XmlEquatable<Hkr>
    with _$HkrXmlSerializableMixin, _HkrEquality {
  @xml.XmlElement(name: 'tist')
  final HkrTemperatur tIst;

  @xml.XmlElement(name: 'tsoll')
  final HkrTemperatur tSoll;

  @xml.XmlElement()
  final HkrTemperatur absenk;

  @xml.XmlElement()
  final HkrTemperatur komfort;

  @xml.XmlElement()
  final bool lock;

  @xml.XmlElement(name: 'devicelock')
  final bool deviceLock;

  @xml.XmlElement(name: 'errorcode')
  final int errorCode;

  @xml.XmlElement(name: 'windowopenactiv')
  final bool windowOpenActive;

  @xml.XmlElement(name: 'windowopenactiveendtime')
  final HkrTimestamp windowOpenActiveEndTime;

  @xml.XmlElement(name: 'boostactive')
  final bool boostActive;

  @xml.XmlElement(name: 'boostactiveendtime')
  final HkrTimestamp boostActiveEndTime;

  @xml.XmlElement(name: 'batterylow')
  final bool batteryLow;

  @xml.XmlElement()
  final BatteryPercentage battery;

  @xml.XmlElement(name: 'nextchange')
  final NextChange nextChange;

  @xml.XmlElement(name: 'summeractive')
  final bool summerActive;

  @xml.XmlElement(name: 'holidayactive')
  final bool holidayActive;

  const Hkr({
    required this.tIst,
    required this.tSoll,
    required this.absenk,
    required this.komfort,
    required this.lock,
    required this.deviceLock,
    required this.errorCode,
    required this.windowOpenActive,
    required this.windowOpenActiveEndTime,
    required this.boostActive,
    required this.boostActiveEndTime,
    required this.batteryLow,
    required this.battery,
    required this.nextChange,
    required this.summerActive,
    required this.holidayActive,
  });

  factory Hkr.fromXmlElement(XmlElement element) =>
      _$HkrFromXmlElement(element);
}

mixin _HkrEquality on XmlEquatable<Hkr> {
  @override
  List<Object?> get props => [
        self.tIst,
        self.tSoll,
        self.absenk,
        self.komfort,
        self.lock,
        self.deviceLock,
        self.errorCode,
        self.windowOpenActive,
        self.windowOpenActiveEndTime,
        self.boostActive,
        self.boostActiveEndTime,
        self.batteryLow,
        self.battery,
        self.nextChange,
        self.summerActive,
        self.holidayActive,
      ];
}
