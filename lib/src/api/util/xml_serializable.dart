import 'package:xml/xml.dart';

abstract class IXmlSerializable {
  IXmlSerializable._();

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  });

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  });

  List<XmlNode> toXmlChildren({Map<String, String?> namespaces = const {}});
}

abstract class IXmlConvertible implements IXmlSerializable {
  IXmlConvertible._();

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  });

  XmlElement toXmlElement({Map<String, String?> namespaces = const {}});
}
