abstract class SimpleActionFailure {
  const SimpleActionFailure._();

  factory SimpleActionFailure.network() => const _Network._();

  factory SimpleActionFailure.unknown() => const _Unknown._();

  T when<T>({
    required T Function() network,
    required T Function() unknown,
  }) {
    if (this is _Network) {
      return network();
    } else if (this is _Unknown) {
      return unknown();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? network,
    T Function()? unknown,
  }) {
    return when(
      network: network ?? orElse,
      unknown: unknown ?? orElse,
    );
  }
}

class _Network extends SimpleActionFailure {
  const _Network._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Network && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'SimpleActionFailure._Network';
}

class _Unknown extends SimpleActionFailure {
  const _Unknown._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Unknown && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'SimpleActionFailure._Unknown';
}
