/// Local cache and key-value storage abstraction.
///
/// Provides a clean interface for storing non-sensitive application state,
/// cached API payloads, user preferences, and temporary session data.
library;

import 'package:ai_hustle_copilot/core/errors/exceptions.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Contract for non-sensitive local storage and data caching.
abstract interface class CacheStorageService {
  /// Reads a cached value associated with [key].
  Future<T?> read<T>(String key);

  /// Writes [value] associated with [key] into local storage.
  Future<void> write<T>({required String key, required T value});

  /// Deletes the cached entry associated with [key].
  Future<void> delete(String key);

  /// Returns `true` if [key] exists in storage.
  Future<bool> containsKey(String key);

  /// Clears all entries from local storage cache.
  Future<void> clear();
}

/// Concrete implementation of [CacheStorageService] backed by Hive.
class HiveStorageServiceImpl implements CacheStorageService {
  HiveStorageServiceImpl({this.box, this.boxName = _defaultBoxName});

  static const String _defaultBoxName = 'ai_hustle_cache_box';

  /// Hive box instance if pre-injected.
  Box<dynamic>? box;

  /// Name of the Hive box.
  final String boxName;

  /// Ensures the underlying Hive box is open before executing an operation.
  Future<Box<dynamic>> _getBox() async {
    if (box != null && box!.isOpen) {
      return box!;
    }

    try {
      box = await Hive.openBox<dynamic>(boxName);
      return box!;
    } catch (e) {
      throw CacheException(
        message: 'Failed to open cache storage box: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<T?> read<T>(String key) async {
    try {
      final b = await _getBox();
      final val = b.get(key);
      if (val is T) return val;
      return null;
    } catch (e) {
      throw CacheException(
        message: 'Failed to read key "$key" from cache storage',
        originalError: e,
      );
    }
  }

  @override
  Future<void> write<T>({required String key, required T value}) async {
    try {
      final b = await _getBox();
      await b.put(key, value);
    } catch (e) {
      throw CacheException(
        message: 'Failed to write key "$key" to cache storage',
        originalError: e,
      );
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      final b = await _getBox();
      await b.delete(key);
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete key "$key" from cache storage',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      final b = await _getBox();
      return b.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clear() async {
    try {
      final b = await _getBox();
      await b.clear();
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear cache storage',
        originalError: e,
      );
    }
  }
}
