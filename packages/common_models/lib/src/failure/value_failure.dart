abstract class ValueFailure {
  const ValueFailure._();

  factory ValueFailure.empty() => const _Empty._();

  factory ValueFailure.invalid() => const _Invalid._();

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
  }) {
    if (this is _Empty) {
      return empty();
    } else if (this is _Invalid) {
      return invalid();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? invalid,
  }) {
    return when(
      empty: empty ?? orElse,
      invalid: invalid ?? orElse,
    );
  }
}

class _Empty extends ValueFailure {
  const _Empty._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'ValueFailure.._Empty';
}

class _Invalid extends ValueFailure {
  const _Invalid._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Invalid && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'ValueFailure._Invalid';
}
