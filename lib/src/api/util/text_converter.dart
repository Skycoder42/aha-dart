import 'dart:async';

import 'package:aha_client/src/api/util/content_type_extractor.dart';
import 'package:chopper/chopper.dart';

import '../aha/models/optional.dart';
import 'combined_converter.dart';

abstract class TextTypeConverter<T> {
  String encode(T data);
  T decode(String data);
}

class TextConverter with ContentTypeExtractor implements Converter {
  static const _textContentType = 'text/plain';

  final _typeConverters = <Type, TextTypeConverter>{};

  void registerConverter<T>(TextTypeConverter<T> converter) =>
      _typeConverters[T] = converter;

  @override
  FutureOr<Request> convertRequest(Request request) {
    return request.copyWith(
      body: _encode(request.body),
    );
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    _checkContentType(response);
    return response.copyWith(
      body: _decode<BodyType, InnerType>(response.bodyString),
    );
  }

  String _encode(dynamic data) {
    if (data is Optional) {
      if (data.isInvalid) {
        return Optional.invalidStringValue;
      } else {
        return _encode(data.value);
      }
    }

    return _findConverter(data.runtimeType).encode(data);
  }

  TBody _decode<TBody, TInner>(String data) {
    if (TBody is Optional) {
      if (data == Optional.invalidStringValue) {
        return const Optional.invalid() as TBody;
      } else {
        return Optional(_decode<TInner, TInner>(data)) as TBody;
      }
    }

    return _findConverter<TBody>().decode(data);
  }

  void _checkContentType(Response response) {
    final contentType = getContentType(response.headers);
    if (contentType != _textContentType) {
      throw ConversionNotSupportedException(
        runtimeType.toString(),
        'Content-Type "$contentType" is not supported',
      );
    }
  }

  TextTypeConverter<T> _findConverter<T>([Type? t]) {
    final converter = _typeConverters[t ?? T] as TextTypeConverter<T>?;
    if (converter == null) {
      throw ConversionNotSupportedException(
        runtimeType.toString(),
        'Type has not been registered for text conversion',
      );
    }

    return converter;
  }
}
