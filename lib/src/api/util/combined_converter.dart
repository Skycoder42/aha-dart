import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';

/// @nodoc
@internal
class ConversionNotSupported extends UnsupportedError {
  /// @nodoc
  final Type type;

  /// @nodoc
  ConversionNotSupported(this.type, String mode)
      : super('Cannot convert $mode of type $type: No converter registered!');
}

/// @nodoc
@internal
abstract class CombinableConverter implements Converter {
  /// @nodoc
  const CombinableConverter();

  /// @nodoc
  List<String> get supportedContentTypes;

  /// @nodoc
  FutureOr<Request?> maybeConvertRequest(Request request);

  @override
  @nonVirtual
  FutureOr<Request> convertRequest(Request request) async {
    final convertedRequest = await maybeConvertRequest(request);
    if (convertedRequest != null) {
      return convertedRequest;
    } else {
      // ignore: avoid_dynamic_calls
      throw ConversionNotSupported(request.body.runtimeType, 'response');
    }
  }
}

/// @nodoc
@internal
class CombinedConverter implements Converter {
  final List<CombinableConverter> _subConverters;

  /// @nodoc
  CombinedConverter([List<CombinableConverter>? converters])
      : _subConverters = converters ?? [];

  /// @nodoc
  void addConverter(CombinableConverter converter) {
    _subConverters.add(converter);
  }

  @override
  FutureOr<Request> convertRequest(Request request) async {
    for (final converter in _subConverters) {
      final convertedRequest = await converter.maybeConvertRequest(request);
      if (convertedRequest != null) {
        return convertedRequest;
      }
    }

    throw ConversionNotSupported(request.runtimeType, 'request');
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    final responseContentType =
        response.headers[contentTypeKey]?.split(';').first;

    for (final converter in _subConverters) {
      final allowedContentTypes = converter.supportedContentTypes;
      if (!allowedContentTypes.contains(responseContentType)) {
        continue;
      }

      return converter.convertResponse<BodyType, InnerType>(response);
    }

    throw ConversionNotSupported(BodyType, 'response');
  }
}
