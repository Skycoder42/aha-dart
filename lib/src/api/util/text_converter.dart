import 'dart:async';

import 'package:chopper/chopper.dart';

import '../aha/models/optional.dart';

abstract class TextTypeConverter<T> {
  String encode(T data);
  T decode(String data);
}

class TextConverter implements Converter {
  final _typeConverters = <Type, TextTypeConverter>{};

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

    final converter = _typeConverters[data.runtimeType];
    return converter?.encode(data) ?? data.toString();
  }

  TBody _decode<TBody, TInner>(String data) {
    if (TBody is Optional) {
      if (data == Optional.invalidStringValue) {
        return const Optional.invalid() as TBody;
      } else {
        return Optional(_decode<TInner, TInner>(data)) as TBody;
      }
    }

    final converter = _typeConverters[TBody] as TextTypeConverter<TBody>?;
    return converter?.decode(data) ?? data as TBody;
  }
}
