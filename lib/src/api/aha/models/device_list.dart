import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'device.dart';

part 'device_list.freezed.dart';
part 'device_list.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class DeviceList with _$DeviceList implements IXmlConvertible {
  static const elementName = 'devicelist';

  static const invalid = DeviceList();

  @xml.XmlSerializable(createMixin: true)
  @xml.XmlRootElement(name: DeviceList.elementName)
  @With.fromString(r'_$_$_DeviceListXmlSerializableMixin')
  @Assert(
    'version == 1',
    'Only the $elementName version 1 format is supported',
  )
  const factory DeviceList({
    @xml.XmlAttribute() @Default(1) int version,
    @xml.XmlAttribute(name: 'fwversion') @Default('') String fwVersion,
    @xml.XmlElement(name: Device.deviceElementName) List<Device>? devices,
    @xml.XmlElement(name: Device.groupElementName)
    @visibleForTesting
        List<Device>? rawGroups,
  }) = _DeviceList;

  factory DeviceList.fromXmlElement(XmlElement element) =>
      _$_$_DeviceListFromXmlElement(element);

  const DeviceList._();

  List<DeviceGroup>? get groups => rawGroups?.cast<DeviceGroup>().toList();
}
