/// Widget tests for Phase 2.5 Authentication Presentation Layer.
library;

import 'package:ai_hustle_copilot/core/constants/app_constants.dart';
import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/auth/auth.dart';
import 'package:ai_hustle_copilot/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: child,
      ),
    );
  }

  group('Authentication Screens Widget Tests', () {
    testWidgets('SplashScreen renders title and branding', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SplashScreen()));
      await tester.pump();

      expect(find.text('AI Hustle'), findsOneWidget);
      expect(find.text('CO-PILOT'), findsOneWidget);

      await tester.pump(AppConstants.splashDuration);
    });

    testWidgets('WelcomeScreen renders headline and CTAs', (tester) async {
      await tester.pumpWidget(createTestableWidget(const WelcomeScreen()));
      await tester.pump();

      expect(find.text('AI Hustle Co-Pilot'), findsOneWidget);
      expect(find.text('Build\nYour AI\nBusiness'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('LoginScreen renders email, password, and sign in button',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const LoginScreen()));
      await tester.pump();

      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('RegisterScreen renders registration form and password strength',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const RegisterScreen()));
      await tester.pump();

      expect(find.text('Create an Account?'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Create account'), findsOneWidget);
    });

    testWidgets('ForgotPasswordScreen renders reset email input',
        (tester) async {
      await tester.pumpWidget(
          createTestableWidget(const ForgotPasswordScreen()));
      await tester.pump();

      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.text('Send Reset Link'), findsOneWidget);
    });

    testWidgets('EmailVerificationScreen renders status and resend button',
        (tester) async {
      await tester.pumpWidget(
          createTestableWidget(const EmailVerificationScreen()));
      await tester.pump();

      expect(find.text('Confirm Your Email OTP'), findsOneWidget);
      expect(find.text('Confirm & Verify'), findsOneWidget);
      expect(find.text('Resend OTP Code'), findsOneWidget);
    });

    testWidgets('VerificationSuccessScreen renders success state and CTA',
        (tester) async {
      await tester.pumpWidget(
          createTestableWidget(const VerificationSuccessScreen()));
      await tester.pump();

      expect(find.text('Account Verified!'), findsOneWidget);
      expect(find.text('Continue to Dashboard'), findsOneWidget);
    });
  });
}
