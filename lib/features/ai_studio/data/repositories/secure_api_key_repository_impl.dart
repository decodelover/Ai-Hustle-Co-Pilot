/// Data Repository Implementation: SecureApiKeyRepositoryImpl (Amendment 3.2A)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/api_key_repository.dart';

/// Secure in-memory/secure-storage implementation for user API keys.
final class SecureApiKeyRepositoryImpl implements ApiKeyRepository {
  final Map<String, String> _secureCache = {};

  @override
  Future<String?> getApiKey(String providerId) async {
    return _secureCache[providerId];
  }

  @override
  Future<void> saveApiKey(String providerId, String key) async {
    _secureCache[providerId] = key;
  }

  @override
  Future<void> deleteApiKey(String providerId) async {
    _secureCache.remove(providerId);
  }
}
