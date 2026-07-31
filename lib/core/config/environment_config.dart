/// Centralized environment configuration model.
///
/// Encapsulates environment-specific properties such as API base URLs,
/// Supabase credentials, logging toggles, and feature flags.
/// Supports multi-environment builds (dev, staging, prod) without hardcoded secrets.
library;

import 'package:ai_hustle_copilot/core/config/app_environment.dart';
import 'package:ai_hustle_copilot/core/config/env.dart';
import 'package:flutter/foundation.dart';

/// Read-only container for environment-specific runtime configuration.
@immutable
class EnvironmentConfig {
  /// Creates an [EnvironmentConfig] instance with explicit options.
  const EnvironmentConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.supabaseUrl,
    required this.supabasePublishableKey,
    required this.geminiApiKey,
    this.enableHttpLogging = true,
    this.enableVerboseErrors = true,
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 15),
  });

  /// Factory for Development environment configuration.
  factory EnvironmentConfig.dev({
    String? apiBaseUrl,
    String? supabaseUrl,
    String? supabasePublishableKey,
    String? geminiApiKey,
  }) {
    return EnvironmentConfig(
      environment: AppEnvironment.dev,
      apiBaseUrl: apiBaseUrl ?? 'https://api.dev.aihustleco.com/v1',
      supabaseUrl: supabaseUrl ?? _getEnvSupabaseUrl(),
      supabasePublishableKey:
          supabasePublishableKey ?? _getEnvSupabasePublishableKey(),
      geminiApiKey: geminiApiKey ?? _getEnvGeminiApiKey(),
    );
  }

  /// Factory for Staging environment configuration.
  factory EnvironmentConfig.staging({
    String? apiBaseUrl,
    String? supabaseUrl,
    String? supabasePublishableKey,
    String? geminiApiKey,
  }) {
    return EnvironmentConfig(
      environment: AppEnvironment.staging,
      apiBaseUrl: apiBaseUrl ?? 'https://api.staging.aihustleco.com/v1',
      supabaseUrl: supabaseUrl ?? _getEnvSupabaseUrl(),
      supabasePublishableKey:
          supabasePublishableKey ?? _getEnvSupabasePublishableKey(),
      geminiApiKey: geminiApiKey ?? _getEnvGeminiApiKey(),
      enableVerboseErrors: false,
    );
  }

  /// Factory for Production environment configuration.
  factory EnvironmentConfig.prod({
    String? apiBaseUrl,
    String? supabaseUrl,
    String? supabasePublishableKey,
    String? geminiApiKey,
  }) {
    return EnvironmentConfig(
      environment: AppEnvironment.prod,
      apiBaseUrl: apiBaseUrl ?? 'https://api.aihustleco.com/v1',
      supabaseUrl: supabaseUrl ?? _getEnvSupabaseUrl(),
      supabasePublishableKey:
          supabasePublishableKey ?? _getEnvSupabasePublishableKey(),
      geminiApiKey: geminiApiKey ?? _getEnvGeminiApiKey(),
      enableHttpLogging: false,
      enableVerboseErrors: false,
    );
  }

  /// Active environment enum.
  final AppEnvironment environment;

  /// Base URL for Dio HTTP requests.
  final String apiBaseUrl;

  /// Supabase backend URL.
  final String supabaseUrl;

  /// Supabase publishable API key (client-safe, RLS-protected).
  final String supabasePublishableKey;

  /// Google Gemini AI API key.
  final String geminiApiKey;

  /// Whether HTTP request/response logging is enabled.
  final bool enableHttpLogging;

  /// Whether detailed error messages are exposed in the UI or logs.
  final bool enableVerboseErrors;

  /// Network connection timeout duration.
  final Duration connectTimeout;

  /// Network receive timeout duration.
  final Duration receiveTimeout;

  /// Whether the Supabase credentials are placeholder values.
  bool get hasPlaceholderCredentials =>
      supabaseUrl.contains('placeholder') ||
      supabasePublishableKey.contains('placeholder');

  static String _getEnvSupabaseUrl() {
    try {
      return Env.supabaseUrl;
    } catch (_) {
      return 'https://placeholder.supabase.co';
    }
  }

  static String _getEnvSupabasePublishableKey() {
    try {
      return Env.supabasePublishableKey;
    } catch (_) {
      return 'placeholder-publishable-key';
    }
  }

  static String _getEnvGeminiApiKey() {
    try {
      return Env.geminiApiKey;
    } catch (_) {
      return '';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentConfig &&
          runtimeType == other.runtimeType &&
          environment == other.environment &&
          apiBaseUrl == other.apiBaseUrl &&
          supabaseUrl == other.supabaseUrl &&
          supabasePublishableKey == other.supabasePublishableKey &&
          geminiApiKey == other.geminiApiKey &&
          enableHttpLogging == other.enableHttpLogging &&
          enableVerboseErrors == other.enableVerboseErrors;

  @override
  int get hashCode => Object.hash(
    environment,
    apiBaseUrl,
    supabaseUrl,
    supabasePublishableKey,
    geminiApiKey,
    enableHttpLogging,
    enableVerboseErrors,
  );

  @override
  String toString() =>
      'EnvironmentConfig('
      'environment: ${environment.name}, '
      'apiBaseUrl: $apiBaseUrl, '
      'enableHttpLogging: $enableHttpLogging'
      ')';
}
