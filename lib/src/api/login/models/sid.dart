import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as xml;

import '../../util/xml_serializable.dart';
import '../login_manager.dart';

part 'sid.freezed.dart';
part 'sid.g.dart';

/// The sessions ID of the currently active session
///
/// {@macro aha_reference}
@Freezed(makeCollectionsUnmodifiable: false)
@xml.XmlSerializable()
abstract class Sid with _$Sid implements IXmlSerializable {
  static const _invalidValue = '0000000000000000';
  static final _sidRegexp = RegExp(r'^[0-9a-z]{16}$', caseSensitive: false);

  /// An invalid session ID
  static const invalid = Sid();

  /// @nodoc
  @internal
  @xml.XmlSerializable(createMixin: true)
  @With.fromString(r'_$_$_SidXmlSerializableMixin')
  @Assert('sid.length == 16', 'must be a 64 bit hex encoded integer')
  const factory Sid({
    /// The string value of this SID
    @xml.XmlText() @Default(Sid._invalidValue) String sid,
  }) = _Sid;

  /// @nodoc
  @internal
  factory Sid.fromXmlElement(XmlElement element) =>
      _$_$_SidFromXmlElement(element);

  /// Creates a new SID from the given [sid] string
  factory Sid.fromString(String sid) {
    if (!_sidRegexp.hasMatch(sid)) {
      throw ArgumentError.value(
        sid,
        'sid',
        'must be a 64 bit hex encoded integer',
      );
    }

    return Sid(sid: sid);
  }

  const Sid._();

  /// Returns true if this ID is valid or false if it is not.
  ///
  /// A valid session ID is only returned from a successful login. This check
  /// does not handle session expiry. To check if a session is still active,
  /// use [LoginManager.checkSessionValid].
  bool get isValid => sid != _invalidValue;

  @override
  String toString() => sid;
}
