abstract class NameFailure {
  const NameFailure._();

  factory NameFailure.empty() => const _Empty._();

  factory NameFailure.tooShort() => const _TooShort._();

  T when<T>({
    required T Function() empty,
    required T Function() tooShort,
  }) {
    if (this is _Empty) {
      return empty();
    } else if (this is _TooShort) {
      return tooShort();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooShort,
  }) {
    return when(
      empty: empty ?? orElse,
      tooShort: tooShort ?? orElse,
    );
  }
}

class _Empty extends NameFailure {
  const _Empty._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'NameFailure._Empty';
}

class _TooShort extends NameFailure {
  const _TooShort._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _TooShort && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'NameFailure._TooShort';
}
