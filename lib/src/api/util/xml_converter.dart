import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import 'combined_converter.dart';
import 'xml_serializable.dart';

/// An error that indicates that the XML document cannot be deserialized because
/// the root element of the document is not as expected.
class InvalidRootElement implements Exception {
  /// The type that the XML could not be deserialized to.
  final Type type;

  /// A list of elements that are supported for the given [type].
  final List<String> exceptedElements;

  /// The actual XML name of the root element of the document.
  final XmlName actualElement;

  /// Default constructor.
  InvalidRootElement(this.type, this.exceptedElements, this.actualElement);

  @override
  String toString() => 'Invalid root element for type $type: '
      'Expected ${exceptedElements.map((e) => '<$e>').join(' or ')}, '
      'but was $actualElement';
}

/// @nodoc
@internal
typedef FromXmlFactory<T> = T Function(XmlElement);

class _XmlConverter<T> {
  final String rootElementName;
  final FromXmlFactory<T> fromXmlElement;
  final List<String>? additionalElementNames;

  const _XmlConverter(
    this.rootElementName,
    this.fromXmlElement,
    this.additionalElementNames,
  );

  List<String> get allowedElementNames =>
      [rootElementName, ...?additionalElementNames];
}

/// @nodoc
@internal
class XmlConverter extends CombinableConverter {
  static const _xmlContentType = 'text/xml';

  final _xmlFactories = <Type, _XmlConverter<Object>>{};

  /// @nodoc
  void registerResponseConverter<T extends IXmlConvertible>(
    String element,
    FromXmlFactory<T> fromXmlElement, [
    List<String>? additionalElementNames,
  ]) =>
      _xmlFactories[T] = _XmlConverter(
        element,
        fromXmlElement,
        additionalElementNames,
      );

  @override
  List<String> get supportedContentTypes =>
      const [_xmlContentType, 'application/xml'];

  @override
  Request? maybeConvertRequest(Request request) {
    final dynamic body = request.body;
    if (body is IXmlConvertible) {
      return _xmlRequest(request).copyWith(
        body: body.toXmlElement().toXmlString(),
      );
    } else if (body is XmlElement) {
      return _xmlRequest(request).copyWith(body: body.toXmlString());
    } else if (body is XmlDocument) {
      return _xmlRequest(request).copyWith(body: body.toXmlString());
    }

    return null;
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    final xmlDocument = XmlDocument.parse(response.bodyString);
    if (BodyType == XmlDocument) {
      return response.copyWith(body: xmlDocument as BodyType);
    }

    final rootElement = xmlDocument.rootElement;
    if (BodyType == XmlElement) {
      return response.copyWith(body: rootElement as BodyType);
    }

    final factory = _getFactory<BodyType>(rootElement.name);
    return response.copyWith<BodyType>(
      body: factory(rootElement),
    );
  }

  Request _xmlRequest(Request request) =>
      applyHeader(request, contentTypeKey, _xmlContentType);

  FromXmlFactory<T> _getFactory<T>(XmlName rootElementName) {
    final factory = _xmlFactories[T];
    if (factory == null) {
      throw ConversionNotSupported(T, 'response');
    }

    if (!factory.allowedElementNames.contains(rootElementName.local)) {
      throw InvalidRootElement(T, factory.allowedElementNames, rootElementName);
    }

    return factory.fromXmlElement as FromXmlFactory<T>;
  }
}
