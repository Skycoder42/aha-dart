import 'package:aha_client/src/api/util/xml_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'device_list_infos.freezed.dart';

@freezed
class DeviceList with _$DeviceList {
  static const XmlTypeConverter<DeviceList> converter =
      _DeviceListTypeConverter();

  const factory DeviceList({
    required String version,
    required String fwversion,
    required List<Device> devices,
  }) = _DeviceList;

  factory DeviceList.fromXml(XmlElement element) {
    assert(element.name.toString() == 'devicelist');

    return DeviceList(
      version: element.getAttribute('version') ?? '',
      fwversion: element.getAttribute('fwversion') ?? '',
      devices: List.unmodifiable(
        element.childElements.map((element) => Device.fromXml(element)),
      ),
    );
  }

  void toXml(XmlBuilder builder) {
    builder.element(
      'devicelist',
      attributes: {
        'version': version,
        'fwversion': fwversion,
      },
      nest: () {
        for (final device in devices) {
          device.toXml(builder);
        }
      },
    );
  }
}

@freezed
class Device with _$Device {
  const factory Device({
    required String identifier,
    required String id,
    required int functionbitmask,
    required String fwversion,
    required String manufacturer,
    required String productname,
    required bool present,
    required bool txbusy,
    required String name,
    required int battery,
    required bool batterylow,
    required dynamic temperature,
    required dynamic hkr,
  }) = _Device;

  factory Device.fromXml(XmlElement element) {
    assert(element.name.toString() == 'device');

    return Device(
      identifier: element.getAttribute('identifier') ?? '',
      id: element.getAttribute('id') ?? '',
      functionbitmask: element.getIntAttribute('functionbitmask') ?? 0,
      fwversion: element.getAttribute('fwversion') ?? '',
      manufacturer: element.getAttribute('manufacturer') ?? '',
      productname: element.getAttribute('productname') ?? '',
      present: element.getBoolElement('present'),
      txbusy: element.getBoolElement('txbusy'),
      name: element.getElement('name')?.text ?? '',
      battery: element.getIntElement('battery') ?? 0,
      batterylow: element.getBoolElement('batterylow'),
      temperature: element.getElement('temperature'),
      hkr: element.getElement('hkr'),
    );
  }

  void toXml(XmlBuilder builder) {
    builder.element(
      'device',
      attributes: {
        'identifier': identifier,
        'id': id,
        'functionbitmask': functionbitmask.toString(),
        'fwversion': fwversion,
        'manufacturer': manufacturer,
        'productname': productname,
      },
      nest: () {
        builder
          ..element('present', nest: present.toXmlString())
          ..element('txbusy', nest: txbusy.toXmlString())
          ..element('name', nest: name)
          ..element('battery', nest: battery)
          ..element('batterylow', nest: batterylow.toXmlString())
          ..element('temperature', nest: temperature)
          ..element('hkr', nest: hkr);
      },
    );
  }
}

class _DeviceListTypeConverter extends SimpleXmlTypeConverter<DeviceList> {
  const _DeviceListTypeConverter();

  @override
  void buildXml(DeviceList data, XmlBuilder builder) => data.toXml(builder);

  @override
  DeviceList parseXml(XmlElement element) => DeviceList.fromXml(element);
}

extension XmlElementX on XmlElement {
  int? getIntAttribute(String name) => int.tryParse(getAttribute(name) ?? '');

  bool getBoolElement(String name) => getElement(name)?.text == '1';

  int? getIntElement(String name) => int.tryParse(getElement(name)?.text ?? '');
}

extension BoolX on bool {
  String toXmlString() => this ? '1' : '0';
}
