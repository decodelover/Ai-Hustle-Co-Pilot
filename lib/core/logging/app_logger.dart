/// Production-safe logging implementation backed by the `logger` package.
///
/// Automatically scrubs sensitive data (passwords, auth tokens, API keys, PII)
/// before emitting logs. Adapts verbosity based on runtime release mode.
library;

import 'package:ai_hustle_copilot/core/logging/logger_service.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Concrete implementation of [LoggerService] with automatic data sanitization.
class AppLoggerService implements LoggerService {
  AppLoggerService({Logger? logger})
    : _logger =
          logger ??
          Logger(
            printer: PrettyPrinter(methodCount: kReleaseMode ? 0 : 3),
            level: kReleaseMode ? Level.warning : Level.debug,
          );

  final Logger _logger;

  // ── Regex Sanitization Patterns ────────────────────────────────────────

  static final RegExp _passwordRegex = RegExp(
    '(password|passwd|pass|secret|credential|token|key|api_key|access_token|refresh_token)\\s*[:=]\\s*["\']?([^"\\s,]+)',
    caseSensitive: false,
  );

  static final RegExp _bearerTokenRegex = RegExp(
    r'Bearer\s+[A-Za-z0-9\-._~+/]+=*',
    caseSensitive: false,
  );

  static final RegExp _emailRegex = RegExp(
    r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b',
  );

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (!kReleaseMode) {
      _logger.d(sanitize(message), error: error, stackTrace: stackTrace);
    }
  }

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.i(sanitize(message), error: error, stackTrace: stackTrace);
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.w(sanitize(message), error: error, stackTrace: stackTrace);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(sanitize(message), error: error, stackTrace: stackTrace);
  }

  @override
  String sanitize(String input) {
    if (input.isEmpty) return input;

    var sanitized = input;

    // 1. Mask Bearer authorization headers
    sanitized = sanitized.replaceAll(
      _bearerTokenRegex,
      'Bearer [REDACTED_TOKEN]',
    );

    // 2. Mask JSON/query key-value credentials
    sanitized = sanitized.replaceAllMapped(_passwordRegex, (match) {
      final key = match.group(1);
      return '$key=[REDACTED_SECRET]';
    });

    // 3. Mask email address PII
    sanitized = sanitized.replaceAllMapped(_emailRegex, (match) {
      final email = match.group(0)!;
      final parts = email.split('@');
      final name = parts.first;
      final domain = parts.last;
      final maskedName = name.length > 2 ? '${name.substring(0, 2)}***' : '***';
      return '$maskedName@$domain';
    });

    return sanitized;
  }
}

/// Static convenience accessor delegating to a default [AppLoggerService] instance.
abstract final class AppLogger {
  static final LoggerService _instance = AppLoggerService();

  /// Logs a debug message.
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _instance.debug(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an info message.
  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    _instance.info(message, error: error, stackTrace: stackTrace);
  }

  /// Logs a warning message.
  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _instance.warning(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an error message.
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _instance.error(message, error: error, stackTrace: stackTrace);
  }

  /// Sanitizes input string.
  static String sanitize(String input) => _instance.sanitize(input);
}
