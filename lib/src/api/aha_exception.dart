import 'package:chopper/chopper.dart' hide body;

class AhaException implements Exception {
  final int statusCode;
  final Object? error;

  AhaException(this.statusCode, this.error);

  @override
  String toString() => 'Request failed ($statusCode): $error';
}

extension AhaExceptionX<TBody extends Object> on Response<TBody> {
  TBody get value {
    if (!isSuccessful || body == null) {
      throw AhaException(statusCode, error ?? bodyString);
    }

    return body!;
  }
}
