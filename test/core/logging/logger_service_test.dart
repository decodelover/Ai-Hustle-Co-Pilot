import 'package:ai_hustle_copilot/core/logging/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLoggerService Sanitization Tests', () {
    late AppLoggerService logger;

    setUp(() {
      logger = AppLoggerService();
    });

    test('sanitizes Bearer authorization tokens', () {
      const logInput = 'Request headers: Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9';
      final sanitized = logger.sanitize(logInput);
      expect(sanitized, isNot(contains('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')));
      expect(sanitized, contains('Bearer [REDACTED_TOKEN]'));
    });

    test('sanitizes password and secret fields', () {
      const logInput = 'User login payload: password="SuperSecret123!", email="test@domain.com"';
      final sanitized = logger.sanitize(logInput);
      expect(sanitized, isNot(contains('SuperSecret123!')));
      expect(sanitized, contains('password=[REDACTED_SECRET]'));
    });

    test('sanitizes API keys and tokens in payload', () {
      const logInput = 'Config payload: api_key=sbp_12345abcdef, token=secret_token_val';
      final sanitized = logger.sanitize(logInput);
      expect(sanitized, isNot(contains('sbp_12345abcdef')));
      expect(sanitized, isNot(contains('secret_token_val')));
      expect(sanitized, contains('api_key=[REDACTED_SECRET]'));
      expect(sanitized, contains('token=[REDACTED_SECRET]'));
    });

    test('masks email address PII', () {
      const logInput = 'User john.doe@example.com logged in';
      final sanitized = logger.sanitize(logInput);
      expect(sanitized, isNot(contains('john.doe@example.com')));
      expect(sanitized, contains('jo***@example.com'));
    });

    test('handles empty input gracefully', () {
      expect(logger.sanitize(''), isEmpty);
    });
  });
}
