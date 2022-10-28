import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'power_meter.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class PowerMeter extends XmlEquatable<PowerMeter>
    with _$PowerMeterXmlSerializableMixin, _PowerMeterEquality {
  @xml.XmlElement(name: 'power')
  @visibleForTesting
  final int powerRaw;

  @xml.XmlElement(name: 'energy')
  @visibleForTesting
  final int energyRaw;

  @xml.XmlElement(name: 'voltage')
  @visibleForTesting
  final int voltageRaw;

  const PowerMeter({
    required this.powerRaw,
    required this.energyRaw,
    required this.voltageRaw,
  });

  factory PowerMeter.fromXmlElement(XmlElement element) =>
      _$PowerMeterFromXmlElement(element);

  double getPowerWatts() => powerRaw / 1000;

  double getEnergyWattHours() => energyRaw.toDouble();

  double getVoltageVolts() => voltageRaw / 1000;
}

mixin _PowerMeterEquality on XmlEquatable<PowerMeter> {
  @override
  List<Object?> get props => [
        self.getPowerWatts(),
        self.getEnergyWattHours(),
        self.getVoltageVolts(),
      ];
}
