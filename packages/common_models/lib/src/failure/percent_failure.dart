abstract class PercentFailure {
  const PercentFailure._();

  static PercentFailure empty() => const _Empty._();

  static PercentFailure invalid() => const _Invalid._();

  static PercentFailure outOfRange() => const _OutOfRange._();

  T when<T extends Object>({
    required T Function() empty,
    required T Function() invalid,
    required T Function() outOfRange,
  }) {
    if (this is _Empty) {
      return empty();
    } else if (this is _Invalid) {
      return invalid();
    } else if (this is _OutOfRange) {
      return outOfRange();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T extends Object>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? invalid,
    T Function()? outOfRange,
  }) {
    return when(
      empty: empty ?? orElse,
      invalid: invalid ?? orElse,
      outOfRange: outOfRange ?? orElse,
    );
  }
}

class _Empty extends PercentFailure {
  const _Empty._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PercentFailure._Empty';
}

class _Invalid extends PercentFailure {
  const _Invalid._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PercentFailure._Invalid';
}

class _OutOfRange extends PercentFailure {
  const _OutOfRange._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PercentFailure._OutOfRange';
}
