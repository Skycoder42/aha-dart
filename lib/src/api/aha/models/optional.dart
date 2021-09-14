import 'package:freezed_annotation/freezed_annotation.dart';

part 'optional.freezed.dart';

@freezed
class Optional<T> with _$Optional<T> {
  static const invalidStringValue = 'inval';

  const Optional._();

  @Assert(
    'value != null',
    'Cannot create optionals for nullable values. '
        'Use Optional.fromValue instead.',
  )
  // ignore: sort_unnamed_constructors_first
  const factory Optional(T value) = _Optional<T>;
  const factory Optional.invalid() = _Invalid<T>;

  factory Optional.fromValue(T? value) =>
      value != null ? Optional(value) : const Optional.invalid();

  bool get isInvalid => map(
        (_) => true,
        invalid: (_) => false,
      );

  T? get value => when(
        (value) => value,
        invalid: () => null,
      );
}
