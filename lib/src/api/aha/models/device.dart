import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'battery_percentage.dart';
import 'hkr.dart';
import 'temperature.dart';

part 'device.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Device extends XmlEquatable<Device>
    with _$DeviceXmlSerializableMixin, _DeviceEquality {
  @xml.XmlAttribute()
  final int id;

  @xml.XmlAttribute()
  final String identifier;

  @xml.XmlAttribute(name: 'functionbitmask')
  final int functionBitMask;

  @xml.XmlAttribute(name: 'fwversion')
  final String fwVersion;

  @xml.XmlAttribute()
  final String manufacturer;

  @xml.XmlAttribute(name: 'productname')
  final String productName;

  @xml.XmlElement()
  final bool present;

  @xml.XmlElement(name: 'txbusy')
  final bool txBusy;

  @xml.XmlElement()
  final String name;

  @xml.XmlElement()
  final BatteryPercentage battery;

  @xml.XmlElement(name: 'batterylow')
  final bool batteryLow;

  @xml.XmlElement(name: 'temperature')
  final Temperature temperature;

  @xml.XmlElement(name: 'hkr')
  final Hkr hkr;

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
    required this.temperature,
    required this.hkr,
  });

  factory Device.fromXmlElement(XmlElement element) =>
      _$DeviceFromXmlElement(element);
}

mixin _DeviceEquality on XmlEquatable<Device> {
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
        self.temperature,
        self.hkr,
      ];
}
