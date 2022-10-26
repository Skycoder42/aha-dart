import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'battery_percentage.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class BatteryPercentage extends XmlEquatable<BatteryPercentage>
    with _$BatteryPercentageXmlSerializableMixin, _BatteryPercentageEquality {
  @xml.XmlText()
  final int rawValue;

  const BatteryPercentage({
    required this.rawValue,
  }) : assert(
          rawValue >= 0 && rawValue <= 100,
          'rawValue must be in range [0, 100]',
        );

  factory BatteryPercentage.fromXmlElement(XmlElement element) =>
      _$BatteryPercentageFromXmlElement(element);

  double getValue() => rawValue / 100;

  @override
  String toString() => '$rawValue%';
}

mixin _BatteryPercentageEquality on XmlEquatable<BatteryPercentage> {
  @override
  List<Object?> get props => [self.getValue()];
}
