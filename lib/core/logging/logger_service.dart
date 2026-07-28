/// Abstract logging interface enforcing Dependency Inversion Principle.
///
/// Decouples features and infrastructure services from the concrete
/// logger implementation (`logger` package).
library;

/// Contract for structured application logging.
abstract interface class LoggerService {
  /// Logs a debug message for development diagnostics.
  void debug(String message, {Object? error, StackTrace? stackTrace});

  /// Logs an informational message for key lifecycle events.
  void info(String message, {Object? error, StackTrace? stackTrace});

  /// Logs a warning for recoverable failures or performance alerts.
  void warning(String message, {Object? error, StackTrace? stackTrace});

  /// Logs an error for unexpected exceptions and failures.
  void error(String message, {Object? error, StackTrace? stackTrace});

  /// Sanitizes sensitive parameters (passwords, tokens, keys, PII) from log text.
  String sanitize(String input);
}
