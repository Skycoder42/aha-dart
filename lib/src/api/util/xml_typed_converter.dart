import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import 'xml_converter.dart';

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

class XmlTypedConverter extends Converter {
  final _xmlConverter = XmlConverter();

  final _typeConverters = <Type, XmlTypeConverter>{};

  void registerConverter<T>(XmlTypeConverter<T> converter) =>
      _typeConverters[T] = converter;

  @override
  FutureOr<Request> convertRequest(Request request) {
    final converter = _typeConverters[request.body.runtimeType];
    if (converter is XmlTypeConverter) {
      return _xmlConverter.convertRequest(
        request.copyWith(
          body: converter.toXml(request.body),
        ),
      );
    } else {
      return _xmlConverter.convertRequest(request);
    }
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) async {
    final converter = _typeConverters[BodyType] as XmlTypeConverter<BodyType>?;
    if (converter is XmlTypeConverter<BodyType>) {
      final xmlResponse = await _xmlConverter
          .convertResponse<XmlDocument, XmlDocument>(response);
      if (xmlResponse.body == null) {
        return xmlResponse.copyWith();
      }

      return xmlResponse.copyWith(
        body: converter.fromXml(xmlResponse.body!),
      );
    } else if (BodyType == XmlDocument) {
      return _xmlConverter.convertResponse<BodyType, InnerType>(response);
    } else {
      return response.copyWith();
    }
  }
}
