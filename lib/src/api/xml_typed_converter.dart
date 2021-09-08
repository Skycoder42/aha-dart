import 'dart:async';

import 'package:aha_client/src/api/xml_converter.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

abstract class TypeConverter<T> {
  const TypeConverter._();

  XmlDocument toXml(T data);
  T fromXml(XmlDocument xml);
}

abstract class SimpleTypeConverter<T> implements TypeConverter<T> {
  const SimpleTypeConverter();

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

  final _typeConverters = <Type, TypeConverter>{};

  void registerConverter<T>(TypeConverter<T> converter) =>
      _typeConverters[T] = converter;

  @override
  FutureOr<Request> convertRequest(Request request) {
    final converter = _typeConverters[request.body.runtimeType];
    if (converter != null) {
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
    final converter = _typeConverters[BodyType] as TypeConverter<BodyType>?;
    if (converter != null) {
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
