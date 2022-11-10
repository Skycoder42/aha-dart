import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import 'energy.dart';
import 'power.dart';
import 'voltage.dart';

part 'power_meter.freezed.dart';
part 'power_meter.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class PowerMeter with _$PowerMeter implements IXmlSerializable {
  static const invalid = PowerMeter();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_PowerMeterXmlSerializableMixin')
  const factory PowerMeter({
    @xml.XmlElement(name: 'power') @Default(Power.invalid) Power power,
    @xml.XmlElement(name: 'energy') @Default(Energy.invalid) Energy energy,
    @xml.XmlElement(name: 'voltage') @Default(Voltage.invalid) Voltage voltage,
  }) = _PowerMeter;

  factory PowerMeter.fromXmlElement(XmlElement element) =>
      _$_$_PowerMeterFromXmlElement(element);
}
