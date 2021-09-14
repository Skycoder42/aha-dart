import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:xml/xml.dart';

class XmlConverter implements Converter {
  static const contentTypeHeader = 'Content-Type';
  static const xmlContentType = 'text/xml';
  static const xmlAltContentType = 'application/xml';

  @override
  FutureOr<Request> convertRequest(Request request) {
    final rawBody = request.body;
    if (rawBody is XmlDocument) {
      return request.copyWith(
        body: rawBody.toXmlString(),
        headers: {
          ...request.headers,
          contentTypeHeader: xmlContentType,
        },
      );
    } else {
      return request;
    }
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    if (BodyType == XmlDocument) {
      final contentType =
          response.headers[contentTypeHeader.toLowerCase()]?.split(';').first;
      if (contentType != xmlContentType && contentType != xmlAltContentType) {
        throw Exception(
          'Cannot decode a response without the XML content type',
        );
      }

      return response.copyWith(
        body: XmlDocument.parse(response.bodyString),
      ) as Response<BodyType>;
    } else {
      return response.copyWith();
    }
  }
}
