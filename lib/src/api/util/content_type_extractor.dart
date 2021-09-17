mixin ContentTypeExtractor {
  static const contentTypeHeader = 'Content-Type';

  String? getContentType(Map<String, String> headers) =>
      headers[contentTypeHeader.toLowerCase()]?.split(';').first;
}
