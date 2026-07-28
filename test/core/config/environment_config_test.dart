import 'package:ai_hustle_copilot/core/config/app_environment.dart';
import 'package:ai_hustle_copilot/core/config/environment_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEnvironment Enum Tests', () {
    test('isDev, isStaging, isProd return correct boolean flags', () {
      const dev = AppEnvironment.dev;
      expect(dev.isDev, isTrue);
      expect(dev.isStaging, isFalse);
      expect(dev.isProd, isFalse);

      const staging = AppEnvironment.staging;
      expect(staging.isDev, isFalse);
      expect(staging.isStaging, isTrue);
      expect(staging.isProd, isFalse);

      const prod = AppEnvironment.prod;
      expect(prod.isDev, isFalse);
      expect(prod.isStaging, isFalse);
      expect(prod.isProd, isTrue);
    });
  });

  group('EnvironmentConfig Factory Tests', () {
    test('dev factory initializes development defaults', () {
      final config = EnvironmentConfig.dev();
      expect(config.environment, AppEnvironment.dev);
      expect(config.apiBaseUrl, contains('dev'));
      expect(config.enableHttpLogging, isTrue);
      expect(config.enableVerboseErrors, isTrue);
    });

    test('staging factory initializes staging defaults', () {
      final config = EnvironmentConfig.staging();
      expect(config.environment, AppEnvironment.staging);
      expect(config.apiBaseUrl, contains('staging'));
      expect(config.enableHttpLogging, isTrue);
      expect(config.enableVerboseErrors, isFalse);
    });

    test('prod factory initializes production defaults', () {
      final config = EnvironmentConfig.prod();
      expect(config.environment, AppEnvironment.prod);
      expect(config.enableHttpLogging, isFalse);
      expect(config.enableVerboseErrors, isFalse);
    });

    test('custom overrides are applied properly', () {
      final config = EnvironmentConfig.dev(
        apiBaseUrl: 'https://custom-api.com',
        supabaseUrl: 'https://custom-supabase.co',
        supabasePublishableKey: 'custom-key',
      );
      expect(config.apiBaseUrl, 'https://custom-api.com');
      expect(config.supabaseUrl, 'https://custom-supabase.co');
      expect(config.supabasePublishableKey, 'custom-key');
    });

    test('equality and hashcode comparison work as expected', () {
      final config1 = EnvironmentConfig.dev(apiBaseUrl: 'https://api.com');
      final config2 = EnvironmentConfig.dev(apiBaseUrl: 'https://api.com');
      final config3 = EnvironmentConfig.prod(apiBaseUrl: 'https://api.com');

      expect(config1, equals(config2));
      expect(config1.hashCode, equals(config2.hashCode));
      expect(config1, isNot(equals(config3)));
    });
  });
}
