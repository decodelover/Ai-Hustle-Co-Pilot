/// Domain Repository Contract: ApiKeyRepository (Amendment 3.2A)
library;

/// Repository handling encrypted local API key storage.
abstract interface class ApiKeyRepository {
  /// Reads stored API key for a provider.
  Future<String?> getApiKey(String providerId);

  /// Saves an API key securely.
  Future<void> saveApiKey(String providerId, String key);

  /// Deletes an API key securely.
  Future<void> deleteApiKey(String providerId);
}
