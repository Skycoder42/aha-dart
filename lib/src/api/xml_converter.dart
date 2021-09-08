import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:xml/xml.dart';

class XmlConverter implements Converter {
  @override
  FutureOr<Request> convertRequest(Request request) {
    final rawBody = request.body;
    if (rawBody is XmlDocument) {
      return request.copyWith(body: rawBody.toXmlString());
    } else {
      return request;
    }
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    if (BodyType == XmlDocument) {
      return response.copyWith(
        body: XmlDocument.parse(response.bodyString),
      ) as Response<BodyType>;
    } else {
      return response.copyWith();
    }
  }
}
