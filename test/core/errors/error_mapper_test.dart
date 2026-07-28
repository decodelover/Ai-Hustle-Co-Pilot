import 'package:ai_hustle_copilot/core/errors/error_mapper.dart';
import 'package:ai_hustle_copilot/core/errors/exceptions.dart';
import 'package:ai_hustle_copilot/core/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorMapper Unit Tests', () {
    test('passes existing Failure through unchanged', () {
      const failure = ServerFailure(message: 'Server error', code: 500);
      final result = ErrorMapper.mapToFailure(failure);
      expect(result, equals(failure));
    });

    test('maps ServerException to ServerFailure', () {
      const exception = ServerException(message: 'Internal server error', statusCode: 500);
      final result = ErrorMapper.mapToFailure(exception);
      expect(result, isA<ServerFailure>());
      expect(result.message, 'Internal server error');
      expect(result.code, 500);
    });

    test('maps UnauthorizedException to UnauthorizedFailure', () {
      const exception = UnauthorizedException();
      final result = ErrorMapper.mapToFailure(exception);
      expect(result, isA<UnauthorizedFailure>());
      expect(result.code, 401);
    });

    test('maps ValidationException to ValidationFailure with fieldErrors', () {
      const exception = ValidationException(
        message: 'Invalid payload',
        fieldErrors: {'email': 'Invalid email format'},
      );
      final result = ErrorMapper.mapToFailure(exception);
      expect(result, isA<ValidationFailure>());
      final valFailure = result as ValidationFailure;
      expect(valFailure.fieldErrors['email'], 'Invalid email format');
    });

    test('maps Dio connection error to NetworkFailure', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );
      final result = ErrorMapper.mapToFailure(dioException);
      expect(result, isA<NetworkFailure>());
    });

    test('maps Dio 401 response to UnauthorizedFailure', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
          data: {'message': 'Invalid session'},
        ),
      );
      final result = ErrorMapper.mapToFailure(dioException);
      expect(result, isA<UnauthorizedFailure>());
      expect(result.message, 'Invalid session');
    });

    test('maps FormatException to ValidationFailure', () {
      const formatError = FormatException('Bad JSON string');
      final result = ErrorMapper.mapToFailure(formatError);
      expect(result, isA<ValidationFailure>());
    });

    test('maps generic Exception to UnknownFailure', () {
      final genericError = Exception('Something bad happened');
      final result = ErrorMapper.mapToFailure(genericError);
      expect(result, isA<UnknownFailure>());
    });
  });

  group('FailureMessageX Unit Tests', () {
    test('toUserMessage returns clean user-facing descriptions', () {
      const networkFailure = NetworkFailure();
      expect(networkFailure.toUserMessage(), contains('No internet connection'));

      const unauthorizedFailure = UnauthorizedFailure();
      expect(unauthorizedFailure.toUserMessage(), contains('session has expired'));

      const notFoundFailure = NotFoundFailure();
      expect(notFoundFailure.toUserMessage(), contains('not found'));
    });
  });
}
