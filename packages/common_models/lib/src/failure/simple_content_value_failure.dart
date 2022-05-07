abstract class SimpleContentValueFailure {
  const SimpleContentValueFailure._();

  static SimpleContentValueFailure empty() => const _Empty._();

  T when<T extends Object>({
    required T Function() empty,
  }) {
    if (this is _Empty) {
      return empty();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T extends Object>({
    required T Function() orElse,
    T Function()? empty,
  }) {
    return when(
      empty: empty ?? orElse,
    );
  }
}

class _Empty extends SimpleContentValueFailure {
  const _Empty._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'SimpleContentValueFailure._Empty';
}
