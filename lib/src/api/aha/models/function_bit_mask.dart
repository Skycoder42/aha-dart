// ignore_for_file: public_member_api_docs

import 'package:enum_flag/enum_flag.dart';

/// A collection of bit masks that define the capabilities of a device.
///
/// {@macro aha_reference}
// ignore: prefer_mixin
enum FunctionBitMaskFlag with EnumFlag {
  hanFunDevice,
  // ignore: unused_field
  _reserved1,
  lightOrLamp,
  // ignore: unused_field
  _reserved3,
  alarmSensor,
  avmButton,
  thermostat,
  energyMeasurementDevice,
  temperatureSensor,
  switchSocket,
  avmDECTRepeater,
  microphone,
  // ignore: unused_field
  _reserved12,
  hanFunUnit,
  // ignore: unused_field
  _reserved14,
  switchableDevice,
  dimmable,
  colorAdjustable,
  blinds;
}
