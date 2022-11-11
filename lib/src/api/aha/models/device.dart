import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'alert.dart';
import 'avm_button.dart';
import 'button.dart';
import 'color_control.dart';
import 'group_info.dart';
import 'hkr.dart';
import 'level_control.dart';
import 'percentage.dart';
import 'power_meter.dart';
import 'simple_on_off.dart';
import 'switch.dart';
import 'temperature.dart';

part 'device.freezed.dart';
part 'device.g.dart';

/// A device with all it's data points.
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Device with _$Device implements IXmlConvertible {
  /// @nodoc
  @internal
  static const deviceElementName = 'device';

  /// @nodoc
  @internal
  static const groupElementName = 'group';

  /// @nodoc
  @internal
  static const invalidDevice = Device();

  /// @nodoc
  @internal
  static const invalidGroup = DeviceGroup();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: Device.deviceElementName)
  @With.fromString(r'_$_$_DeviceXmlSerializableMixin')
  const factory Device({
    @xml.XmlAttribute() @Default(0) int id,
    @xml.XmlAttribute() @Default('') String identifier,
    @xml.XmlAttribute(name: 'fwversion') @Default('') String fwVersion,
    @xml.XmlAttribute() @Default('') String manufacturer,
    @xml.XmlAttribute(name: 'productname') @Default('') String productName,
    @xml.XmlAttribute(name: 'functionbitmask') @Default(0) int functionBitMask,
    @xml.XmlElement() @Default(false) bool present,
    @xml.XmlElement(name: 'txbusy') @Default(false) bool txBusy,
    @xml.XmlElement() @Default('') String name,
    @xml.XmlElement() Percentage? battery,
    @xml.XmlElement(name: 'batterylow') bool? batteryLow,
    @xml.XmlElement(name: 'switch') Switch? switch_,
    @xml.XmlElement(name: 'powermeter') PowerMeter? powerMeter,
    @xml.XmlElement(name: 'temperature') Temperature? temperature,
    @xml.XmlElement() Alert? alert,
    @xml.XmlElement(name: 'button') List<Button>? buttons,
    @xml.XmlElement(name: 'avmbutton') AvmButton? avmButton,

    // TODO HAN-FUN devices

    @xml.XmlElement(name: 'simpleonoff') SimpleOnOff? simpleOnOff,
    @xml.XmlElement(name: 'levelcontrol') LevelControl? levelControl,
    @xml.XmlElement(name: 'colorcontrol') ColorControl? colorControl,
    @xml.XmlElement(name: 'hkr') Hkr? hkr,
  }) = _Device;

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: Device.groupElementName)
  @With.fromString(r'_$_$DeviceGroupXmlSerializableMixin')
  const factory Device.group({
    @xml.XmlAttribute() @Default(0) int id,
    @xml.XmlAttribute() @Default('') String identifier,
    @xml.XmlAttribute(name: 'fwversion') @Default('') String fwVersion,
    @xml.XmlAttribute() @Default('') String manufacturer,
    @xml.XmlAttribute(name: 'productname') @Default('') String productName,
    @xml.XmlAttribute(name: 'functionbitmask') @Default(0) int functionBitMask,
    @xml.XmlElement() @Default(false) bool present,
    @xml.XmlElement(name: 'txbusy') @Default(false) bool txBusy,
    @xml.XmlElement() @Default('') String name,
    @xml.XmlElement() Percentage? battery,
    @xml.XmlElement(name: 'batterylow') bool? batteryLow,
    @xml.XmlElement(name: 'switch') Switch? switch_,
    @xml.XmlElement(name: 'powermeter') PowerMeter? powerMeter,
    @xml.XmlElement(name: 'temperature') Temperature? temperature,
    @xml.XmlElement() Alert? alert,
    @xml.XmlElement(name: 'button') List<Button>? buttons,
    @xml.XmlElement(name: 'avmbutton') AvmButton? avmButton,

    // TODO HAN-FUN devices

    @xml.XmlElement(name: 'simpleonoff') SimpleOnOff? simpleOnOff,
    @xml.XmlElement(name: 'levelcontrol') LevelControl? levelControl,
    @xml.XmlElement(name: 'colorcontrol') ColorControl? colorControl,
    @xml.XmlElement(name: 'hkr') Hkr? hkr,

    // groups specific, all before is identical
    @xml.XmlElement(name: 'groupinfo')
    @Default(GroupInfo.invalid)
        GroupInfo groupInfo,
  }) = DeviceGroup;

  /// @nodoc
  @internal
  factory Device.fromXmlElement(XmlElement element) {
    switch (element.localName) {
      case deviceElementName:
        return _$_$_DeviceFromXmlElement(element);
      case groupElementName:
        return _$_$DeviceGroupFromXmlElement(element);
      default:
        throw ArgumentError.value(
          element,
          'element',
          'Must be a <device> or a <group> element',
        );
    }
  }
}
