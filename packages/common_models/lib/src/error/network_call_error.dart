enum NetworkCallError {
  network,
  unknown,
  internalServer;

  T when<T>({
    required T Function() network,
    required T Function() unknown,
    required T Function() internalServer,
  }) {
    switch (this) {
      case NetworkCallError.network:
        return network();
      case NetworkCallError.unknown:
        return unknown();
      case NetworkCallError.internalServer:
        return internalServer();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? network,
    T Function()? unknown,
    T Function()? internalServer,
  }) {
    return when(
      network: network ?? orElse,
      unknown: unknown ?? orElse,
      internalServer: internalServer ?? orElse,
    );
  }
}
