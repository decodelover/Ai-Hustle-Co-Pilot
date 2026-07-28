import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/value_object_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Password Value Object', () {
    test('valid password passes initialization', () {
      final password = Password('P@ssword123');
      expect(password.value, 'P@ssword123');
      expect(password.toString(), '[REDACTED_PASSWORD]');
    });

    test('password shorter than minLength throws AuthValidationException', () {
      expect(
        () => Password('Short1!'),
        throwsA(isA<AuthValidationException>()),
      );
      expect(
        () => Password('Custom1', minLength: 10),
        throwsA(isA<AuthValidationException>()),
      );
    });

    test('character detection helpers work as expected', () {
      final simple = Password('password');
      expect(simple.hasLowercase, isTrue);
      expect(simple.hasUppercase, isFalse);
      expect(simple.hasDigit, isFalse);
      expect(simple.hasSpecialCharacter, isFalse);
      expect(simple.isStrong, isFalse);

      final upper = Password('Password');
      expect(upper.hasUppercase, isTrue);
      expect(upper.isStrong, isFalse);

      final digit = Password('Password1');
      expect(digit.hasDigit, isTrue);
      expect(digit.isStrong, isFalse);

      final strong = Password('P@ssword1');
      expect(strong.hasUppercase, isTrue);
      expect(strong.hasLowercase, isTrue);
      expect(strong.hasDigit, isTrue);
      expect(strong.hasSpecialCharacter, isTrue);
      expect(strong.isStrong, isTrue);
    });

    test('password equality and hashcode comparison work', () {
      final p1 = Password('Secret123!');
      final p2 = Password('Secret123!');
      final p3 = Password('Different1!');

      expect(p1, equals(p2));
      expect(p1.hashCode, equals(p2.hashCode));
      expect(p1, isNot(equals(p3)));
    });
  });
}
