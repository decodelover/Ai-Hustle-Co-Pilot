/// Data layer implementation of the domain [AuthRepository] interface.
library;

import 'dart:async';
import 'dart:io';

import 'package:ai_hustle_copilot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ai_hustle_copilot/features/auth/data/mappers/auth_user_mapper.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Concrete implementation of [AuthRepository] bridging data sources to the domain layer.
///
/// Responsibilities:
/// - Delegates network auth tasks to [AuthRemoteDataSource]
/// - Maps DTOs ([AuthUserDto]) into domain entities ([AuthUser])
/// - Catches raw exceptions and translates them into domain [AuthFailure] objects
/// - Ensures zero Supabase models leak into domain or presentation layers
class AuthRepositoryImpl implements AuthRepository {
  /// Constructs an [AuthRepositoryImpl] with injected [AuthRemoteDataSource].
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  /// The injected remote auth data source.
  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<AuthUser> signIn({
    required Email email,
    required Password password,
  }) async {
    try {
      final dto = await remoteDataSource.signIn(
        email: email.value,
        password: password.value,
      );
      return AuthUserMapper.dtoToEntity(dto);
    } catch (e, s) {
      throw _mapExceptionToAuthFailure(e, s);
    }
  }

  @override
  Future<AuthUser> signUp({
    required Email email,
    required Password password,
    String? displayName,
  }) async {
    try {
      final dto = await remoteDataSource.signUp(
        email: email.value,
        password: password.value,
        displayName: displayName,
      );
      return AuthUserMapper.dtoToEntity(dto);
    } catch (e, s) {
      throw _mapExceptionToAuthFailure(e, s);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } catch (e, s) {
      throw _mapExceptionToAuthFailure(e, s);
    }
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      final dto = await remoteDataSource.currentUser();
      if (dto == null) return null;
      return AuthUserMapper.dtoToEntity(dto);
    } catch (e, s) {
      throw _mapExceptionToAuthFailure(e, s);
    }
  }

  @override
  Stream<AuthUser?> observeAuthState() {
    return remoteDataSource.authStateChanges().map((dto) {
      if (dto == null) return null;
      return AuthUserMapper.dtoToEntity(dto);
    }).transform(
      StreamTransformer<AuthUser?, AuthUser?>.fromHandlers(
        handleError: (error, stackTrace, sink) {
          sink.addError(_mapExceptionToAuthFailure(error, stackTrace));
        },
      ),
    );
  }

  @override
  Future<void> sendPasswordResetEmail({
    required Email email,
  }) async {
    try {
      await remoteDataSource.resetPassword(email: email.value);
    } catch (e, s) {
      throw _mapExceptionToAuthFailure(e, s);
    }
  }

  @override
  Future<void> resendVerificationEmail({
    required Email email,
  }) async {
    try {
      await remoteDataSource.resendVerification(email: email.value);
    } catch (e, s) {
      throw _mapExceptionToAuthFailure(e, s);
    }
  }

  @override
  Future<AuthUser?> refreshSession() async {
    try {
      final dto = await remoteDataSource.refreshSession();
      if (dto == null) return null;
      return AuthUserMapper.dtoToEntity(dto);
    } catch (e, s) {
      throw _mapExceptionToAuthFailure(e, s);
    }
  }

  /// Maps raw exceptions (Supabase, network, system) into domain [AuthFailure] instances.
  AuthFailure _mapExceptionToAuthFailure(Object error, StackTrace? stackTrace) {
    if (error is AuthFailure) {
      return error;
    }

    final errorString = error.toString().toLowerCase();

    if (error is SocketException ||
        error is TimeoutException ||
        errorString.contains('socketexception') ||
        errorString.contains('failed host lookup') ||
        errorString.contains('clientexception')) {
      return const NetworkFailure();
    }

    if (error is supabase.AuthException) {
      final msg = error.message.toLowerCase();
      final statusCode = int.tryParse(error.statusCode ?? '');

      if (msg.contains('invalid login credentials') ||
          msg.contains('invalid_credentials')) {
        return const InvalidCredentialsFailure();
      }

      if (msg.contains('already registered') ||
          msg.contains('user already exists')) {
        return const EmailAlreadyExistsFailure();
      }

      if (msg.contains('email not confirmed') ||
          msg.contains('not confirmed')) {
        return const EmailNotVerifiedFailure();
      }

      if (msg.contains('weak password') ||
          msg.contains('password should be')) {
        return const WeakPasswordFailure();
      }

      if (msg.contains('refresh_token') ||
          msg.contains('session_not_found') ||
          statusCode == 401) {
        return const SessionExpiredFailure();
      }

      if (msg.contains('rate limit') || msg.contains('too many requests')) {
        return UnknownAuthFailure(
          message: 'Too many requests. Please try again later.',
          code: statusCode ?? 429,
        );
      }

      return UnknownAuthFailure(
        message: error.message.isNotEmpty
            ? error.message
            : 'Authentication failed. Please try again.',
        code: statusCode,
      );
    }

    return UnknownAuthFailure(
      message: error.toString().replaceAll('Exception:', '').trim(),
    );
  }
}
