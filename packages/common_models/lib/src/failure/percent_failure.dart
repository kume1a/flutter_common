abstract class PercentFailure {
  factory PercentFailure.empty() => const _Empty._();

  factory PercentFailure.invalid() => const _Invalid._();

  factory PercentFailure.outOfRange() => const _OutOfRange._();
}

class _Empty implements PercentFailure {
  const _Empty._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PercentFailure._Empty';
}

class _Invalid implements PercentFailure {
  const _Invalid._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PercentFailure._Invalid';
}

class _OutOfRange implements PercentFailure {
  const _OutOfRange._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PercentFailure._OutOfRange';
}
