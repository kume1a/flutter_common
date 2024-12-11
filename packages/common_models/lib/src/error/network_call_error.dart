enum NetworkCallError {
  network,
  unknown,
  internalServer;

  T when<T>({
    required T Function() network,
    required T Function() unknown,
    required T Function() internalServer,
  }) {
    return switch (this) {
      NetworkCallError.network => network(),
      NetworkCallError.unknown => unknown(),
      NetworkCallError.internalServer => internalServer(),
    };
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
