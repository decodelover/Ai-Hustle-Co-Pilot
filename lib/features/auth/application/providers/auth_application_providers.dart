/// Centralized Riverpod providers for Authentication controllers and state.
library;

import 'package:ai_hustle_copilot/features/auth/application/controllers/refresh_session_controller.dart';
import 'package:ai_hustle_copilot/features/auth/application/controllers/resend_verification_controller.dart';
import 'package:ai_hustle_copilot/features/auth/application/controllers/reset_password_controller.dart';
import 'package:ai_hustle_copilot/features/auth/application/controllers/sign_in_controller.dart';
import 'package:ai_hustle_copilot/features/auth/application/controllers/sign_out_controller.dart';
import 'package:ai_hustle_copilot/features/auth/application/controllers/sign_up_controller.dart';
import 'package:ai_hustle_copilot/features/auth/application/controllers/verify_otp_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for [SignInController].
final signInControllerProvider =
    AsyncNotifierProvider.autoDispose<SignInController, void>(
      SignInController.new,
    );

/// Provider for [SignUpController].
final signUpControllerProvider =
    AsyncNotifierProvider.autoDispose<SignUpController, void>(
      SignUpController.new,
    );

/// Provider for [SignOutController].
final signOutControllerProvider =
    AsyncNotifierProvider.autoDispose<SignOutController, void>(
      SignOutController.new,
    );

/// Provider for [ResetPasswordController].
final resetPasswordControllerProvider =
    AsyncNotifierProvider.autoDispose<ResetPasswordController, void>(
      ResetPasswordController.new,
    );

/// Provider for [ResendVerificationController].
final resendVerificationControllerProvider =
    AsyncNotifierProvider.autoDispose<ResendVerificationController, void>(
      ResendVerificationController.new,
    );

/// Provider for [RefreshSessionController].
final refreshSessionControllerProvider =
    AsyncNotifierProvider.autoDispose<RefreshSessionController, void>(
      RefreshSessionController.new,
    );

/// Provider for [VerifyOtpController].
final verifyOtpControllerProvider =
    AsyncNotifierProvider.autoDispose<VerifyOtpController, void>(
      VerifyOtpController.new,
    );
