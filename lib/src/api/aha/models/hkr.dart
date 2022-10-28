import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'hkr_temperature.dart';
import 'next_change.dart';
import 'percentage.dart';
import 'switch_state.dart';
import 'timestamp.dart';

part 'hkr.g.dart';

@xml.XmlEnum()
enum HkrError {
  @xml.XmlValue('0')
  noError,
  @xml.XmlValue('1')
  incorrectInstallation,
  @xml.XmlValue('2')
  incompatibleValveOrLowBattery,
  @xml.XmlValue('3')
  valveBlocked,
  @xml.XmlValue('4')
  preparingInstallation,
  @xml.XmlValue('5')
  installationReady,
  @xml.XmlValue('6')
  installationInProgress,
}

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
  final SwitchState lock;

  @xml.XmlElement(name: 'devicelock')
  final SwitchState deviceLock;

  @xml.XmlElement(name: 'errorcode')
  final HkrError errorCode;

  @xml.XmlElement(name: 'windowopenactiv')
  final bool windowOpenActive;

  @xml.XmlElement(name: 'windowopenactiveendtime')
  final Timestamp windowOpenActiveEndTime;

  @xml.XmlElement(name: 'boostactive')
  final bool boostActive;

  @xml.XmlElement(name: 'boostactiveendtime')
  final Timestamp boostActiveEndTime;

  @xml.XmlElement(name: 'batterylow')
  final bool batteryLow;

  @xml.XmlElement()
  final Percentage battery;

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
