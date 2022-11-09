import '../../util/text_convertible.dart';

enum SwitchAction implements ITextConvertible {
  off(0),
  on(1),
  toggle(2);

  final int value;

  const SwitchAction(this.value);

  @override
  String toText() => value.toString();
}
