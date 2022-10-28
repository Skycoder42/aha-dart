import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';

part 'percentage.g.dart';

@xml.XmlSerializable(createMixin: true)
@immutable
class Percentage extends XmlEquatable<Percentage>
    with _$PercentageXmlSerializableMixin, _PercentageEquality {
  @xml.XmlText()
  @visibleForTesting
  final int rawValue;

  const Percentage({
    required this.rawValue,
  }) : assert(
          rawValue >= 0 && rawValue <= 100,
          'rawValue must be in range [0, 100]',
        );

  factory Percentage.fromXmlElement(XmlElement element) =>
      _$PercentageFromXmlElement(element);

  double getPercentage() => rawValue / 100;

  @override
  String toString() => '$rawValue%';
}

mixin _PercentageEquality on XmlEquatable<Percentage> {
  @override
  List<Object?> get props => [self.getPercentage()];
}

const _invalidPercentageValue = -9999;

@xml.XmlSerializable(createMixin: true)
@immutable
class OptionalPercentage extends XmlEquatable<Percentage>
    with
        _$OptionalPercentageXmlSerializableMixin,
        _PercentageEquality
    implements
        // ignore: avoid_implementing_value_types
        Percentage {
  @override
  @xml.XmlText()
  @visibleForTesting
  final int rawValue;

  const OptionalPercentage({
    required this.rawValue,
  }) : assert(
          rawValue == _invalidPercentageValue ||
              rawValue >= 0 && rawValue <= 100,
          'rawValue must be in range [0, 100] or $_invalidPercentageValue',
        );

  factory OptionalPercentage.fromXmlElement(XmlElement element) =>
      _$OptionalPercentageFromXmlElement(element);

  bool isValid() => rawValue != _invalidPercentageValue;

  @override
  double getPercentage() =>
      rawValue != _invalidPercentageValue ? rawValue / 100 : 0;

  @override
  String toString() =>
      rawValue != _invalidPercentageValue ? '$rawValue%' : 'invalid';
}
