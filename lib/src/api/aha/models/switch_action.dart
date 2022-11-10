enum SwitchAction {
  off(0),
  on(1),
  toggle(2);

  final int value;

  const SwitchAction(this.value);

  @override
  String toString({bool pretty = false}) =>
      pretty ? super.toString() : value.toString();
}
