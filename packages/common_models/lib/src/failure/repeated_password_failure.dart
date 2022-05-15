abstract class RepeatedPasswordFailure {
  const RepeatedPasswordFailure._();

  factory RepeatedPasswordFailure.empty() => const _Empty._();

  factory RepeatedPasswordFailure.doesNotMatch() => const _DoesNotMatch._();

  T when<T>({
    required T Function() empty,
    required T Function() doesNotMatch,
  }) {
    if (this is _Empty) {
      return empty();
    } else if (this is _DoesNotMatch) {
      return doesNotMatch();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? doesNotMatch,
  }) {
    return when(
      empty: empty ?? orElse,
      doesNotMatch: doesNotMatch ?? orElse,
    );
  }
}

class _Empty extends RepeatedPasswordFailure {
  const _Empty._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'RepeatedPasswordFailure._Empty';
}

class _DoesNotMatch extends RepeatedPasswordFailure {
  const _DoesNotMatch._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _DoesNotMatch && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'RepeatedPasswordFailure._DoesNotMatch';
}
