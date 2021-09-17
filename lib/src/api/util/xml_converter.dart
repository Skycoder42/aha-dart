import 'dart:async';

import 'package:aha_client/src/api/util/content_type_extractor.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import 'combined_converter.dart';

abstract class XmlTypeConverter<T> {
  const XmlTypeConverter._();

  XmlDocument toXml(T data);
  T fromXml(XmlDocument xml);
}

abstract class SimpleXmlTypeConverter<T> implements XmlTypeConverter<T> {
  const SimpleXmlTypeConverter();

  @override
  T fromXml(XmlDocument xml) => parseXml(xml.rootElement);

  @override
  XmlDocument toXml(T data) {
    final builder = XmlBuilder()..processing('xml', 'version="1.0"');
    buildXml(data, builder);
    return builder.buildDocument();
  }

  @protected
  void buildXml(T data, XmlBuilder builder);

  @protected
  T parseXml(XmlElement element);
}

class XmlConverter with ContentTypeExtractor implements Converter {
  static const _xmlContentType = 'text/xml';
  static const _allowedXmlContentTypes = [_xmlContentType, 'application/xml'];

  final _typeConverters = <Type, XmlTypeConverter>{
    XmlDocument: const _XmlDocumentConverter(),
  };

  void registerConverter<T>(XmlTypeConverter<T> converter) =>
      _typeConverters[T] = converter;

  @override
  FutureOr<Request> convertRequest(Request request) {
    final converter = _findConverter(request.body.runtimeType);
    return request.copyWith(
      body: converter.toXml(request.body).toXmlString(),
      headers: {
        ...request.headers,
        ContentTypeExtractor.contentTypeHeader: _xmlContentType,
      },
    );
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    _checkContentType(response);

    final converter = _findConverter<BodyType>();
    return response.copyWith(
      body: converter.fromXml(XmlDocument.parse(response.bodyString)),
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

  XmlTypeConverter<T> _findConverter<T>([Type? t]) {
    final converter = _typeConverters[t ?? T] as XmlTypeConverter<T>?;
    if (converter == null) {
      throw ConversionNotSupportedException(
        runtimeType.toString(),
        'Type has not been registered for XML conversion',
      );
    }

    return converter;
  }
}

class _XmlDocumentConverter implements XmlTypeConverter<XmlDocument> {
  const _XmlDocumentConverter();

  @override
  XmlDocument fromXml(XmlDocument xml) => xml;

  @override
  XmlDocument toXml(XmlDocument data) => data;
}
