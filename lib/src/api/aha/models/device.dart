import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'alert.dart';
import 'avm_button.dart';
import 'button.dart';
import 'color_control.dart';
import 'hkr.dart';
import 'level_control.dart';
import 'percentage.dart';
import 'power_meter.dart';
import 'simple_on_off.dart';
import 'switch.dart';
import 'temperature.dart';

part 'device.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Device extends XmlEquatable<Device>
    with _$DeviceXmlSerializableMixin, DeviceEquality {
  @xml.XmlAttribute()
  final int id;

  @xml.XmlAttribute()
  final String identifier;

  @xml.XmlAttribute(name: 'fwversion')
  final String fwVersion;

  @xml.XmlAttribute()
  final String manufacturer;

  @xml.XmlAttribute(name: 'productname')
  final String productName;

  @xml.XmlAttribute(name: 'functionbitmask')
  final int functionBitMask;

  @xml.XmlElement()
  final bool present;

  @xml.XmlElement(name: 'txbusy')
  final bool txBusy;

  @xml.XmlElement()
  final String name;

  @xml.XmlElement()
  final Percentage? battery;

  @xml.XmlElement(name: 'batterylow')
  final bool? batteryLow;

  @xml.XmlElement(name: 'switch')
  final Switch? $switch;

  @xml.XmlElement(name: 'powermeter')
  final PowerMeter? powerMeter;

  @xml.XmlElement(name: 'temperature')
  final Temperature? temperature;

  @xml.XmlElement()
  final Alert? alert;

  @xml.XmlElement(name: 'button')
  final List<Button>? buttons;

  @xml.XmlElement(name: 'avmbutton')
  final AvmButton? avmButton;

  // TODO HAN-FUN devices

  @xml.XmlElement(name: 'simpleonoff')
  final SimpleOnOff? simpleOnOff;

  @xml.XmlElement(name: 'levelcontrol')
  final LevelControl? levelControl;

  @xml.XmlElement(name: 'colorcontrol')
  final ColorControl? colorControl;

  @xml.XmlElement(name: 'hkr')
  final Hkr? hkr;

  const Device({
    required this.id,
    required this.identifier,
    required this.functionBitMask,
    required this.fwVersion,
    required this.manufacturer,
    required this.productName,
    required this.present,
    required this.txBusy,
    required this.name,
    required this.battery,
    required this.batteryLow,
    required this.$switch,
    required this.powerMeter,
    required this.temperature,
    required this.alert,
    required this.buttons,
    required this.avmButton,
    required this.simpleOnOff,
    required this.levelControl,
    required this.colorControl,
    required this.hkr,
  });

  factory Device.fromXmlElement(XmlElement element) =>
      _$DeviceFromXmlElement(element);
}

@internal
mixin DeviceEquality on XmlEquatable<Device> {
  @override
  List<Object?> get props => [
        self.id,
        self.identifier,
        self.functionBitMask,
        self.fwVersion,
        self.manufacturer,
        self.productName,
        self.present,
        self.txBusy,
        self.name,
        self.battery,
        self.batteryLow,
        self.$switch,
        self.powerMeter,
        self.temperature,
        self.alert,
        self.buttons,
        self.avmButton,
        self.simpleOnOff,
        self.levelControl,
        self.colorControl,
        self.hkr,
      ];
}
