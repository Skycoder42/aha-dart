import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';

class UnsupportedDataException implements Exception {
  final String _message;
  final Type _type;
  final Map<String, String> _reasons;

  UnsupportedDataException._(this._message, this._type, this._reasons);

  @override
  String toString() =>
      '$_message. No converter could convert $_type. Reasons:\n'
      '${_reasons.entries.map((e) => '${e.key}: ${e.value}').join('\n')}';
}

@internal
class CombinedConverter implements Converter {
  final List<Converter> _subConverters;

  CombinedConverter([Iterable<Converter>? converters])
      : _subConverters = converters?.toList() ?? [];

  void addConverter(Converter converter) {
    _subConverters.add(converter);
  }

  @override
  FutureOr<Request> convertRequest(Request request) {
    final failures = <_ErrorInfo>[];
    for (final converter in _subConverters) {
      try {
        return converter.convertRequest(request);
      } on ConversionNotSupportedException catch (e) {
        failures.add(_ErrorInfo(converter.runtimeType, e));
      }
    }

    throw failures.toRequestException(request);
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    final failures = <_ErrorInfo>[];
    for (final converter in _subConverters) {
      try {
        return converter.convertResponse<BodyType, InnerType>(response);
      } on ConversionNotSupportedException catch (e) {
        failures.add(_ErrorInfo(converter.runtimeType, e));
      }
    }

    throw failures.toResponseException<BodyType>(response);
  }
}

@internal
class ConversionNotSupportedException implements Exception {
  final String converterType;
  final String reason;

  ConversionNotSupportedException(this.converterType, this.reason);
}

class _ErrorInfo {
  final Type converter;
  final ConversionNotSupportedException exception;

  const _ErrorInfo(this.converter, this.exception);
}

extension _ErrorInfoListX on Iterable<_ErrorInfo> {
  UnsupportedDataException toRequestException(Request request) =>
      UnsupportedDataException._(
        'Failed to convert request to '
        '$request', // TODO formatting of request
        // ignore: avoid_dynamic_calls
        request.body.runtimeType,
        _asMap(),
      );

  UnsupportedDataException toResponseException<TBody>(Response response) =>
      UnsupportedDataException._(
        'Failed to convert response from ${response.base.request?.url}',
        TBody,
        _asMap(),
      );

  Map<String, String> _asMap() => Map.fromEntries(
        map((i) => MapEntry(i.converter.toString(), i.exception.toString())),
      );
}
