abstract class FetchFailure {
  const FetchFailure._();

  static FetchFailure server() => const _Server._();

  static FetchFailure network() => const _Network._();

  static FetchFailure unknown() => const _Unknown._();

  T when<T extends Object>({
    required T Function() server,
    required T Function() network,
    required T Function() unknown,
  }) {
    if (this is _Server) {
      return server();
    } else if (this is _Network) {
      return network();
    } else if (this is _Server) {
      return server();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T extends Object>({
    required T Function() orElse,
    T Function()? server,
    T Function()? network,
    T Function()? unknown,
  }) {
    return when(
      server: server ?? orElse,
      network: network ?? orElse,
      unknown: unknown ?? orElse,
    );
  }
}

class _Server extends FetchFailure {
  const _Server._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Server && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'FetchFailure._Server';
}

class _Network extends FetchFailure {
  const _Network._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Network && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'FetchFailure._Network';
}

class _Unknown extends FetchFailure {
  const _Unknown._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Unknown && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'FetchFailure._Unknown';
}
