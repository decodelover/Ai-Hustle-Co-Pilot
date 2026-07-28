import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_services.dart';

void main() {
  group('SecureStorageService Unit Tests', () {
    late MockSecureStorageService storage;

    setUp(() {
      storage = MockSecureStorageService();
    });

    test('write and read operations work as expected', () async {
      await storage.write(key: 'auth_token', value: 'jwt_token_val');
      final value = await storage.read('auth_token');
      expect(value, equals('jwt_token_val'));
    });

    test('read returns null for non-existent key', () async {
      final value = await storage.read('non_existent');
      expect(value, isNull);
    });

    test('delete removes key from storage', () async {
      await storage.write(key: 'refresh_token', value: 'refresh_val');
      await storage.delete('refresh_token');
      final value = await storage.read('refresh_token');
      expect(value, isNull);
    });

    test('clear wipes all stored credentials', () async {
      await storage.write(key: 'k1', value: 'v1');
      await storage.write(key: 'k2', value: 'v2');
      await storage.clear();

      expect(await storage.read('k1'), isNull);
      expect(await storage.read('k2'), isNull);
    });
  });

  group('CacheStorageService Unit Tests', () {
    late MockCacheStorageService cache;

    setUp(() {
      cache = MockCacheStorageService();
    });

    test('write and read typed values', () async {
      await cache.write<String>(key: 'user_name', value: 'John Doe');
      await cache.write<int>(key: 'user_id', value: 42);

      expect(await cache.read<String>('user_name'), equals('John Doe'));
      expect(await cache.read<int>('user_id'), equals(42));
    });

    test('containsKey returns accurate presence', () async {
      await cache.write<bool>(key: 'is_dark_mode', value: true);
      expect(await cache.containsKey('is_dark_mode'), isTrue);
      expect(await cache.containsKey('is_light_mode'), isFalse);
    });

    test('delete and clear remove cached data', () async {
      await cache.write<String>(key: 'temp_key', value: 'temp_value');
      await cache.delete('temp_key');
      expect(await cache.containsKey('temp_key'), isFalse);

      await cache.write<String>(key: 'key1', value: 'val1');
      await cache.clear();
      expect(await cache.containsKey('key1'), isFalse);
    });
  });
}
