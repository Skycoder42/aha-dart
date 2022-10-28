import 'package:enum_flag/enum_flag.dart';

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
