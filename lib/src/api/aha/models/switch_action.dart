import 'package:meta/meta.dart';

/// The possible actions to perform on a switch device
enum SwitchAction {
  /// Turn the device off.
  off(0),

  /// Turn the device on.
  on(1),

  /// Toggle the device state.
  toggle(2);

  /// @nodoc
  @internal
  final int value;

  /// @nodoc
  @internal
  const SwitchAction(this.value);

  @override
  String toString({bool pretty = false}) =>
      pretty ? super.toString() : value.toString();
}
