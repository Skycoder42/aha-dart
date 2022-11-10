import 'package:chopper/chopper.dart';

import 'combined_converter.dart';

typedef FromTextFactory<T> = T Function(String);

class UnexpectedNullableResponse extends UnsupportedError {
  final Type type;

  UnexpectedNullableResponse(this.type)
      : super(
          'Response has "inval" value which indicates a null response, '
          'but response type $type is not nullable!',
        );
}

class TextConverter extends CombinableConverter {
  static const _invalidValue = 'inval';

  static const _textContentType = 'text/plain';

  final _fromTextFactories = <Type, FromTextFactory<Object>>{
    String: identity,
    int: int.parse,
    double: double.parse,
    bool: _boolFromString,
  };

  void registerResponseConverter<T extends Object>(
    FromTextFactory<T> converter,
  ) =>
      _fromTextFactories[T] = converter;

  @override
  List<String> get supportedContentTypes => const [_textContentType];

  @override
  Request? maybeConvertRequest(Request request) => request.copyWith(
        body: _encode(request.body),
      );

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(
    Response response,
  ) =>
      response.copyWith(
        body: _decode<BodyType, InnerType>(response.bodyString),
      );

  String _encode(dynamic data) {
    if (data is Iterable) {
      return data.map(_encode).join(',');
    } else if (data == null) {
      return _invalidValue;
    } else {
      return data.toString();
    }
  }

  TBody _decode<TBody, TInner>(String data) {
    if (data == _invalidValue) {
      // ignore: prefer_void_to_null
      if (isTypeOf<TBody, Null>()) {
        return null as TBody;
      } else {
        throw UnexpectedNullableResponse(TBody);
      }
    } else if (isTypeOf<TBody, List<TInner>>()) {
      return data.split(',').map(_decode<TInner, TInner>).toList() as TBody;
    } else {
      return _getFactory<TBody>()(data);
    }
  }

  FromTextFactory<T> _getFactory<T>() {
    final factory = _fromTextFactories[T] as FromTextFactory<T>?;
    if (factory == null) {
      throw ConversionNotSupported(T, 'response');
    }

    return factory;
  }
}

bool _boolFromString(String s) {
  switch (s.toLowerCase()) {
    case '0':
    case 'no':
    case 'false':
      return false;
    case '1':
    case 'yes':
    case 'true':
      return true;
    default:
      throw ArgumentError.value(s);
  }
}
