import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/value_object_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email Value Object', () {
    test('valid email parses and normalizes correctly', () {
      final email = Email('  User.Name@Example.COM ');
      expect(email.value, 'user.name@example.com');
      expect(email.toString(), 'user.name@example.com');
    });

    test('empty string throws AuthValidationException', () {
      expect(() => Email('   '), throwsA(isA<AuthValidationException>()));
    });

    test('invalid email format throws AuthValidationException', () {
      final invalidEmails = [
        'plainaddress',
        r'#@%^%#$@#$@#.com',
        '@example.com',
        'Joe Blow <joe@example.com>',
        'email.example.com',
        'email@example@example.com',
        '.email@example.com',
        'email..email@example.com',
        'email@example.com (Joe Blow)',
        'email@example',
        'email@-example.com',
        'email@example..com',
      ];

      for (final invalid in invalidEmails) {
        expect(
          () => Email(invalid),
          throwsA(isA<AuthValidationException>()),
          reason: 'Failed for email: $invalid',
        );
      }
    });

    test('email equality and hashcode comparison work', () {
      final email1 = Email('test@example.com');
      final email2 = Email(' TEST@example.com ');
      final email3 = Email('other@example.com');

      expect(email1, equals(email2));
      expect(email1.hashCode, equals(email2.hashCode));
      expect(email1, isNot(equals(email3)));
    });
  });
}
