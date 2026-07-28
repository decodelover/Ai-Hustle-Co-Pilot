/// Test doubles and mock implementations for core infrastructure services.
library;

import 'package:ai_hustle_copilot/core/logging/logger_service.dart';
import 'package:ai_hustle_copilot/core/network/network_info.dart';
import 'package:ai_hustle_copilot/core/security/secure_storage_service.dart';
import 'package:ai_hustle_copilot/core/storage/cache_storage_service.dart';

/// In-memory implementation of [SecureStorageService] for unit testing.
class MockSecureStorageService implements SecureStorageService {
  final Map<String, String> _data = {};

  @override
  Future<String?> read(String key) async => _data[key];

  @override
  Future<void> write({required String key, required String value}) async {
    _data[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> clear() async {
    _data.clear();
  }

  /// Helper to check stored map contents in tests.
  Map<String, String> get rawStorage => Map.unmodifiable(_data);
}

/// In-memory implementation of [CacheStorageService] for unit testing.
class MockCacheStorageService implements CacheStorageService {
  final Map<String, dynamic> _data = {};

  @override
  Future<T?> read<T>(String key) async {
    final val = _data[key];
    if (val is T) return val;
    return null;
  }

  @override
  Future<void> write<T>({required String key, required T value}) async {
    _data[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _data.remove(key);
  }

  @override
  Future<bool> containsKey(String key) async => _data.containsKey(key);

  @override
  Future<void> clear() async {
    _data.clear();
  }
}

/// Recording mock implementation of [LoggerService] for unit testing.
class MockLoggerService implements LoggerService {
  final List<String> logs = [];

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    logs.add('DEBUG: ${sanitize(message)}');
  }

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    logs.add('INFO: ${sanitize(message)}');
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    logs.add('WARN: ${sanitize(message)}');
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    logs.add('ERROR: ${sanitize(message)}');
  }

  @override
  String sanitize(String input) {
    return input.replaceAll('secret123', '[REDACTED]');
  }
}

/// Mock implementation of [NetworkInfo] with controllable connectivity status.
class MockNetworkInfo implements NetworkInfo {
  MockNetworkInfo({this.isConnectedValue = true});

  bool isConnectedValue;

  @override
  Future<bool> get isConnected async => isConnectedValue;
}
