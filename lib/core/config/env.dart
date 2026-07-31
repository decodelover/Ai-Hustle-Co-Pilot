/// Compile-time environment configuration using Envied.
///
/// This class reads environment variables at build time and generates
/// a type-safe Dart accessor via `envied_generator`. Secrets are
/// obfuscated in the generated file to prevent trivial extraction.
///
/// ## Setup
/// 1. Copy `.env.example` to `.env` in the project root.
/// 2. Fill in your Supabase and Gemini AI credentials.
/// 3. Run `dart run build_runner build --delete-conflicting-outputs`.
///
/// ## Security
/// - The `.env` file is excluded from version control via `.gitignore`.
/// - Generated code uses obfuscation — values are not plain text.
/// - For production, inject environment variables via CI/CD pipelines.
library;

import 'package:envied/envied.dart';

part 'env.g.dart';

/// Type-safe environment variable accessor.
///
/// Generated code lives in `env.g.dart`. Re-run `build_runner`
/// after modifying `.env` or adding new fields.
@Envied(path: '.env', obfuscate: true)
abstract class Env {
  /// The Supabase project URL.
  ///
  /// Example: `https://your-project.supabase.co`
  @EnviedField(varName: 'SUPABASE_URL')
  static final String supabaseUrl = _Env.supabaseUrl;

  /// The Supabase publishable API key (formerly anon key).
  ///
  /// This key is safe to embed in client applications — it only
  /// grants access allowed by Row Level Security (RLS) policies.
  @EnviedField(varName: 'SUPABASE_PUBLISHABLE_KEY')
  static final String supabasePublishableKey = _Env.supabasePublishableKey;

  /// Google Gemini AI API Key.
  @EnviedField(varName: 'GEMINI_API_KEY')
  static final String geminiApiKey = _Env.geminiApiKey;
}
