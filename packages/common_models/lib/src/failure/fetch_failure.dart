enum FetchFailure {
  network,
  server,
  unknown;

  T when<T>({
    required T Function() server,
    required T Function() network,
    required T Function() unknown,
  }) {
    switch (this) {
      case FetchFailure.network:
        return network();
      case FetchFailure.server:
        return server();
      case FetchFailure.unknown:
        return unknown();
    }
  }

  T maybeWhen<T>({
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
