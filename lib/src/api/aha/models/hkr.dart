import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'hkr_temperature.dart';
import 'next_change.dart';
import 'percentage.dart';
import 'switch_state.dart';
import 'timestamp.dart';

part 'hkr.freezed.dart';
part 'hkr.g.dart';

/// Possible error states of a thermostat
@xml.XmlEnum()
enum HkrError {
  @xml.XmlValue('0')
  // ignore: public_member_api_docs
  noError,
  @xml.XmlValue('1')
  // ignore: public_member_api_docs
  incorrectInstallation,
  @xml.XmlValue('2')
  // ignore: public_member_api_docs
  incompatibleValveOrLowBattery,
  @xml.XmlValue('3')
  // ignore: public_member_api_docs
  valveBlocked,
  @xml.XmlValue('4')
  // ignore: public_member_api_docs
  preparingInstallation,
  @xml.XmlValue('5')
  // ignore: public_member_api_docs
  installationReady,
  @xml.XmlValue('6')
  // ignore: public_member_api_docs
  installationInProgress,
}

/// The configuration of a thermostat.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Hkr with _$Hkr implements IXmlSerializable {
  /// @nodoc
  @internal
  static const invalid = Hkr();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_HkrXmlSerializableMixin')
  const factory Hkr({
    @xml.XmlElement(name: 'tist')
    @Default(HkrTemperature.invalid)
    HkrTemperature tIst,
    @xml.XmlElement(name: 'tsoll')
    @Default(HkrTemperature.invalid)
    HkrTemperature tSoll,
    @xml.XmlElement() @Default(HkrTemperature.invalid) HkrTemperature absenk,
    @xml.XmlElement() @Default(HkrTemperature.invalid) HkrTemperature komfort,
    @xml.XmlElement() @Default(SwitchState.invalid) SwitchState lock,
    @xml.XmlElement(name: 'devicelock')
    @Default(SwitchState.invalid)
    SwitchState deviceLock,
    @xml.XmlElement(name: 'errorcode')
    @Default(HkrError.noError)
    HkrError errorCode,
    @xml.XmlElement(name: 'windowopenactiv')
    @Default(false)
    bool windowOpenActive,
    @xml.XmlElement(name: 'windowopenactiveendtime')
    @Default(Timestamp.deactivated)
    Timestamp windowOpenActiveEndTime,
    @xml.XmlElement(name: 'boostactive') @Default(false) bool boostActive,
    @xml.XmlElement(name: 'boostactiveendtime')
    @Default(Timestamp.deactivated)
    Timestamp boostActiveEndTime,
    @xml.XmlElement(name: 'batterylow') @Default(false) bool batteryLow,
    @xml.XmlElement() @Default(Percentage.invalid) Percentage battery,
    @xml.XmlElement(name: 'nextchange')
    @Default(NextChange.invalid)
    NextChange nextChange,
    @xml.XmlElement(name: 'summeractive') @Default(false) bool summerActive,
    @xml.XmlElement(name: 'holidayactive') @Default(false) bool holidayActive,
  }) = _Hkr;

  /// @nodoc
  @internal
  factory Hkr.fromXmlElement(XmlElement element) =>
      _$_$_HkrFromXmlElement(element);
}
