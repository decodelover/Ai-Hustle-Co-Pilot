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
      child: MaterialApp(theme: AppTheme.lightTheme, home: child),
    );
  }

  Widget createAccessibleWidget(
    Widget child, {
    required ThemeData theme,
    TextScaler textScaler = TextScaler.noScaling,
  }) {
    return ProviderScope(
      child: MaterialApp(
        theme: theme,
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: textScaler),
            child: child,
          ),
        ),
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
      expect(find.text('Welcome to AI\nHustle Co-Pilot!'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
      expect(find.bySemanticsLabel('Onboarding step 1 of 4'), findsOneWidget);
    });

    testWidgets('LoginScreen renders email, password, and sign in button', (
      tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const LoginScreen()));
      await tester.pump();

      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets(
      'RegisterScreen renders registration form and password strength',
      (tester) async {
        await tester.pumpWidget(createTestableWidget(const RegisterScreen()));
        await tester.pump();

        expect(find.text('Create your account'), findsOneWidget);
        expect(find.text('Full name'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Sign Up'), findsOneWidget);
      },
    );

    testWidgets('ForgotPasswordScreen renders reset email input', (
      tester,
    ) async {
      await tester.pumpWidget(
        createTestableWidget(const ForgotPasswordScreen()),
      );
      await tester.pump();

      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Send reset link'), findsOneWidget);
    });

    testWidgets('EmailVerificationScreen renders status and resend button', (
      tester,
    ) async {
      await tester.pumpWidget(
        createTestableWidget(const EmailVerificationScreen()),
      );
      await tester.pump();

      expect(find.text('Confirm your email'), findsOneWidget);
      expect(find.text('Verify email'), findsOneWidget);
      expect(find.textContaining('Resend code'), findsOneWidget);
    });

    testWidgets('VerificationSuccessScreen renders success state and CTA', (
      tester,
    ) async {
      await tester.pumpWidget(
        createTestableWidget(const VerificationSuccessScreen()),
      );
      await tester.pump();

      expect(find.text('Email confirmed'), findsOneWidget);
      expect(find.text('Continue to Dashboard'), findsOneWidget);
    });

    testWidgets('LoginScreen supports a small phone and large text', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createAccessibleWidget(
          const LoginScreen(),
          theme: AppTheme.lightTheme,
          textScaler: const TextScaler.linear(1.6),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('RegisterScreen adapts to a dark tablet landscape', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createAccessibleWidget(
          const RegisterScreen(),
          theme: AppTheme.darkTheme,
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Sign Up'), findsOneWidget);
    });
  });
}
