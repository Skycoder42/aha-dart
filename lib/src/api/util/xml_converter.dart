import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:xml/xml.dart';

import 'combined_converter.dart';
import 'content_type_extractor.dart';
import 'xml_convertible.dart';

typedef XmlFactory<T> = T Function(XmlElement);

class XmlConverter with ContentTypeExtractor implements Converter {
  static const _xmlContentType = 'text/xml';
  static const _allowedXmlContentTypes = [_xmlContentType, 'application/xml'];

  final _xmlFactories = <String, XmlFactory<Object>>{};

  void registerConverter<T extends XmlConvertible>(
    String element,
    XmlFactory<T> fromXmlElement,
  ) =>
      _xmlFactories[element] = fromXmlElement;

  @override
  FutureOr<Request> convertRequest(Request request) {
    final dynamic body = request.body;
    if (body is XmlConvertible) {
      return request.copyWith(
        headers: {
          ...request.headers,
          contentTypeKey: _xmlContentType,
        },
        body: body.toXmlElement().toXmlString(),
      );
    }

    return request;
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    _checkContentType(response);

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

  void _checkContentType(Response response) {
    final contentType = getContentType(response.headers);
    if (!_allowedXmlContentTypes.contains(contentType)) {
      throw ConversionNotSupportedException(
        runtimeType.toString(),
        'Content-Type "$contentType" is not supported',
      );
    }
  }

  XmlFactory<T> _getFactory<T>(XmlName rootElementName) {
    final factory = _xmlFactories[rootElementName.local];
    if (factory == null) {
      throw ConversionNotSupportedException(
        runtimeType.toString(),
        'Element <${rootElementName.local}> '
        'has not been registered for XML conversion',
      );
    }

    return factory as XmlFactory<T>;
  }
}
