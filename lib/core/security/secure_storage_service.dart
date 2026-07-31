/// Secure storage service for sensitive credentials.
///
/// Abstracts `flutter_secure_storage` behind a clean interface
/// to decouple the application from the underlying storage
/// implementation. Tokens, API keys, and user credentials
/// should be stored here — never in Hive or SharedPreferences.
library;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstraction for reading and writing encrypted key-value data.
///
/// All sensitive data (auth tokens, refresh tokens, API keys)
/// must flow through this service. The underlying implementation
/// uses platform-specific secure enclaves:
/// - **Android**: EncryptedSharedPreferences (AES-256)
/// - **iOS**: Keychain Services
abstract interface class SecureStorageService {
  /// Reads the value associated with [key], or `null` if absent.
  Future<String?> read(String key);

  /// Writes [value] associated with [key], overwriting if present.
  Future<void> write({required String key, required String value});

  /// Deletes the value associated with [key].
  Future<void> delete(String key);

  /// Removes all entries from secure storage.
  ///
  /// Use with caution — typically called during sign-out or
  /// account deletion flows.
  Future<void> clear();
}

/// Default implementation of [SecureStorageService] backed by
/// `flutter_secure_storage`.
///
/// Configured with Android-specific options for EncryptedSharedPreferences
/// to ensure AES-256 encryption at rest.
class SecureStorageServiceImpl implements SecureStorageService {
  SecureStorageServiceImpl({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> clear() => _storage.deleteAll();
}
