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
    throw UnimplementedError();
  }

  void toXml(XmlBuilder builder) {
    builder.element(
      'devicelist',
      attributes: {
        'version': version,
        'fwversion': fwversion,
      },
    );
  }
}

@freezed
class Device with _$Device {
  const factory Device() = _Device;
}

class _DeviceListTypeConverter extends SimpleXmlTypeConverter<DeviceList> {
  const _DeviceListTypeConverter();

  @override
  void buildXml(DeviceList data, XmlBuilder builder) => data.toXml(builder);

  @override
  DeviceList parseXml(XmlElement element) => DeviceList.fromXml(element);
}
