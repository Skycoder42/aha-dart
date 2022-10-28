import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'alert.dart';
import 'avm_button.dart';
import 'button.dart';
import 'color_control.dart';
import 'device.dart';
import 'group_info.dart';
import 'hkr.dart';
import 'level_control.dart';
import 'percentage.dart';
import 'power_meter.dart';
import 'simple_on_off.dart';
import 'switch.dart';
import 'temperature.dart';

part 'group.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Group extends XmlEquatable<Device>
    with
        _$GroupXmlSerializableMixin,
        DeviceEquality,
        _GroupEquality
    implements
        // ignore: avoid_implementing_value_types
        Device {
  @override
  @xml.XmlAttribute()
  final int id;

  @override
  @xml.XmlAttribute()
  final String identifier;

  @override
  @xml.XmlAttribute(name: 'fwversion')
  final String fwVersion;

  @override
  @xml.XmlAttribute()
  final String manufacturer;

  @override
  @xml.XmlAttribute(name: 'productname')
  final String productName;

  @override
  @xml.XmlAttribute(name: 'functionbitmask')
  final int functionBitMask;

  @override
  @xml.XmlElement()
  final bool present;

  @override
  @xml.XmlElement(name: 'txbusy')
  final bool txBusy;

  @override
  @xml.XmlElement()
  final String name;

  @override
  @xml.XmlElement()
  final Percentage? battery;

  @override
  @xml.XmlElement(name: 'batterylow')
  final bool? batteryLow;

  @override
  @xml.XmlElement(name: 'switch')
  final Switch? $switch;

  @override
  @xml.XmlElement(name: 'powermeter')
  final PowerMeter? powerMeter;

  @override
  @xml.XmlElement(name: 'temperature')
  final Temperature? temperature;

  @override
  @xml.XmlElement()
  final Alert? alert;

  @override
  @xml.XmlElement(name: 'button')
  final List<Button>? buttons;

  @override
  @xml.XmlElement(name: 'avmbutton')
  final AvmButton? avmButton;

  // TODO HAN-FUN devices

  @override
  @xml.XmlElement(name: 'simpleonoff')
  final SimpleOnOff? simpleOnOff;

  @override
  @xml.XmlElement(name: 'levelcontrol')
  final LevelControl? levelControl;

  @override
  @xml.XmlElement(name: 'colorcontrol')
  final ColorControl? colorControl;

  @override
  @xml.XmlElement(name: 'hkr')
  final Hkr? hkr;

  @xml.XmlElement(name: 'groupinfo')
  final GroupInfo groupInfo;

  const Group({
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
    required this.groupInfo,
  });

  factory Group.fromXmlElement(XmlElement element) =>
      _$GroupFromXmlElement(element);
}

mixin _GroupEquality on DeviceEquality {
  @override
  @protected
  Group get self => this as Group;

  @override
  List<Object?> get props => [
        ...super.props,
        self.groupInfo,
      ];
}
