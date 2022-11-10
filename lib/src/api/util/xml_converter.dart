import 'package:chopper/chopper.dart';
import 'package:xml/xml.dart';

import 'combined_converter.dart';
import 'xml_serializable.dart';

typedef FromXmlFactory<T> = T Function(XmlElement);

class _XmlConverter<T> {
  final String rootElementName;
  final FromXmlFactory<T> fromXmlElement;
  final List<String>? additionalElementNames;

  const _XmlConverter(
    this.rootElementName,
    this.fromXmlElement,
    this.additionalElementNames,
  );

  List<String> get allowedElementNames =>
      [rootElementName, ...?additionalElementNames];
}

class InvalidRootElement implements Exception {
  final List<String> exceptedElements;
  final XmlName actualElement;

  InvalidRootElement(this.exceptedElements, this.actualElement);

  @override
  String toString() => 'Invalid root element: '
      'Expected ${exceptedElements.map((e) => '<$e>').join(' or ')}, '
      'but was $actualElement';
}

class XmlConverter extends CombinableConverter {
  static const _xmlContentType = 'text/xml';

  final _xmlFactories = <Type, _XmlConverter<Object>>{};

  void registerResponseConverter<T extends IXmlConvertible>(
    String element,
    FromXmlFactory<T> fromXmlElement, [
    List<String>? additionalElementNames,
  ]) =>
      _xmlFactories[T] = _XmlConverter(
        element,
        fromXmlElement,
        additionalElementNames,
      );

  @override
  List<String> get supportedContentTypes =>
      const [_xmlContentType, 'application/xml'];

  @override
  Request? maybeConvertRequest(Request request) {
    final dynamic body = request.body;
    if (body is IXmlConvertible) {
      return _xmlRequest(request).copyWith(
        body: body.toXmlElement().toXmlString(),
      );
    } else if (body is XmlElement) {
      return _xmlRequest(request).copyWith(body: body.toXmlString());
    } else if (body is XmlDocument) {
      return _xmlRequest(request).copyWith(body: body.toXmlString());
    }

    return null;
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    final xmlDocument = XmlDocument.parse(response.bodyString);
    if (BodyType == XmlDocument) {
      return response.copyWith(body: xmlDocument as BodyType);
    }

    final rootElement = xmlDocument.rootElement;
    if (BodyType == XmlElement) {
      return response.copyWith(body: rootElement as BodyType);
    }

    final factory = _getFactory<BodyType>(rootElement.name);
    return response.copyWith<BodyType>(
      body: factory(rootElement),
    );
  }

  Request _xmlRequest(Request request) =>
      applyHeader(request, contentTypeKey, _xmlContentType);

  FromXmlFactory<T> _getFactory<T>(XmlName rootElementName) {
    final factory = _xmlFactories[T] as _XmlConverter<T>?;
    if (factory == null) {
      throw ConversionNotSupported(T, 'response');
    }

    if (!factory.allowedElementNames.contains(rootElementName.local)) {
      throw InvalidRootElement(factory.allowedElementNames, rootElementName);
    }

    return factory.fromXmlElement;
  }
}
