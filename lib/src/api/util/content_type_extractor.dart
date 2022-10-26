import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';

mixin ContentTypeExtractor {
  @protected
  String? getContentType(Map<String, String> headers) =>
      headers[contentTypeKey]?.split(';').first;
}
