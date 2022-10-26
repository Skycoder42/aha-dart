import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'device.dart';

part 'device_list.g.dart';

const deviceListElementName = 'devicelist';

@xml.XmlSerializable(createMixin: true)
@xml.XmlRootElement(name: deviceListElementName)
@immutable
class DeviceList extends XmlConvertible<DeviceList>
    with _$DeviceListXmlSerializableMixin, _DeviceListEquality {
  @xml.XmlAttribute()
  final int version;

  @xml.XmlAttribute(name: 'fwversion')
  final String fwVersion;

  @xml.XmlElement(name: 'device')
  final List<Device>? devices;

  const DeviceList({
    required this.version,
    required this.fwVersion,
    required this.devices,
  }) : assert(
          version == 1,
          'Only the$deviceListElementName format version 1 is supported',
        );

  factory DeviceList.fromXmlElement(XmlElement element) =>
      _$DeviceListFromXmlElement(element);
}

mixin _DeviceListEquality on XmlConvertible<DeviceList> {
  @override
  List<Object?> get props => [self.version, self.fwVersion, self.devices];
}
