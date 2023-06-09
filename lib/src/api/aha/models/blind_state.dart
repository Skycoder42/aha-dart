// ignore_for_file: public_member_api_docs

/// The state of a blinds device.
///
/// {@macro aha_reference}
enum BlindState {
  open,

  close,

  stop;

  @override
  String toString() => name;
}
