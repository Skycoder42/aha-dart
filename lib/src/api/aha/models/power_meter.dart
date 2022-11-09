import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'power_meter.freezed.dart';
part 'power_meter.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class PowerMeter with _$PowerMeter implements IXmlSerializable {
  static const invalid = PowerMeter();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_PowerMeterXmlSerializableMixin')
  const factory PowerMeter({
    /// The power in mW
    @xml.XmlElement(name: 'power') @Default(0) int power,

    /// The energy in Wh
    @xml.XmlElement(name: 'energy') @Default(0) int energy,
    @xml.XmlElement(name: 'voltage')
    @visibleForOverriding
    @Default(0)
        int voltageRaw,
  }) = _PowerMeter;

  factory PowerMeter.fromXmlElement(XmlElement element) =>
      _$_$_PowerMeterFromXmlElement(element);

  const PowerMeter._();

  /// The energy in voltage
  double get voltage => voltageRaw / 1000;

  @override
  String toString() => 'PowerMeter(powerRaw: $power W, '
      'energyRaw: $energy Wh, '
      'voltageRaw: $voltage) V';
}
