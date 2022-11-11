import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

/// @nodoc
@internal
abstract class IXmlSerializable {
  IXmlSerializable._();

  /// @nodoc
  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  });

  /// @nodoc
  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  });

  /// @nodoc
  List<XmlNode> toXmlChildren({Map<String, String?> namespaces = const {}});
}

/// @nodoc
@internal
abstract class IXmlConvertible implements IXmlSerializable {
  IXmlConvertible._();

  /// @nodoc
  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  });

  /// @nodoc
  XmlElement toXmlElement({Map<String, String?> namespaces = const {}});
}
