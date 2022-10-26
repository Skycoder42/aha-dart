import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

abstract class XmlEquatable<TSelf extends Object> extends Equatable {
  const XmlEquatable();

  @protected
  TSelf get self => this as TSelf;

  @override
  @visibleForOverriding
  bool? get stringify => true;
}

abstract class XmlConvertible<TSelf extends Object>
    extends XmlEquatable<TSelf> {
  const XmlConvertible();

  XmlElement toXmlElement();
}
