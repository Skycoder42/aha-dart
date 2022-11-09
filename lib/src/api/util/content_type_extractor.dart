import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';

class InvalidContentType implements Exception {
  final Type responseType;
  final String contentType;
  final List<String> allowedContentTypes;

  InvalidContentType(
    this.responseType,
    this.contentType,
    this.allowedContentTypes,
  );

  @override
  String toString() => 'Server returned unsupported content type $contentType '
      'for response of type $responseType. '
      'Allowed content types are: $allowedContentTypes';
}

mixin ContentTypeExtractor {
  @protected
  String? getContentType(Map<String, String> headers) =>
      headers[contentTypeKey]?.split(';').first;

  void checkContentType<BodyType>(
    Response response,
    List<String> allowedContentTypes,
  ) {
    final contentType = getContentType(response.headers);
    if (!allowedContentTypes.contains(contentType)) {
      throw InvalidContentType(
        BodyType,
        contentType ?? '<none>',
        allowedContentTypes,
      );
    }
  }
}
