/// Network connectivity checking abstraction.
///
/// Decouples repositories and state providers from platform-specific
/// connectivity plugins or raw network sockets.
library;

/// Contract for querying device internet connectivity.
abstract interface class NetworkInfo {
  /// Returns `true` if the device currently has active network connectivity.
  Future<bool> get isConnected;
}

/// Concrete implementation of [NetworkInfo].
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl({this.isConnectedOverride = true});

  final bool isConnectedOverride;

  @override
  Future<bool> get isConnected async => isConnectedOverride;
}
