import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_convertible.dart';
import 'hkr_temperature.dart';
import 'timestamp.dart';

part 'next_change.freezed.dart';
part 'next_change.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class NextChange with _$NextChange implements IXmlSerializable {
  static const invalid = NextChange();

  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_NextChangeXmlSerializableMixin')
  const factory NextChange({
    @xml.XmlElement(name: 'endperiod')
    @Default(Timestamp.invalid)
        Timestamp endPeriod,
    @xml.XmlElement(name: 'tchange')
    @Default(HkrTemperature.invalid)
        HkrTemperature tChange,
  }) = _NextChange;

  factory NextChange.fromXmlElement(XmlElement element) =>
      _$_$_NextChangeFromXmlElement(element);
}
