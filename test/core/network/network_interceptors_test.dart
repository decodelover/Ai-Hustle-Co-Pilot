import 'package:ai_hustle_copilot/core/config/environment_config.dart';
import 'package:ai_hustle_copilot/core/errors/exceptions.dart';
import 'package:ai_hustle_copilot/core/network/dio_client.dart';
import 'package:ai_hustle_copilot/core/network/interceptors/auth_interceptor.dart';
import 'package:ai_hustle_copilot/core/network/interceptors/error_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_services.dart';

void main() {
  group('AuthInterceptor Tests', () {
    late MockSecureStorageService mockStorage;
    late AuthInterceptor interceptor;

    setUp(() {
      mockStorage = MockSecureStorageService();
      interceptor = AuthInterceptor(secureStorage: mockStorage);
    });

    test(
      'attaches Authorization header when token is present in storage',
      () async {
        await mockStorage.write(
          key: AuthInterceptor.tokenStorageKey,
          value: 'test_token_123',
        );

        final options = RequestOptions(path: '/user');
        final handler = _MockRequestInterceptorHandler();

        await interceptor.onRequest(options, handler);

        expect(
          options.headers['Authorization'],
          equals('Bearer test_token_123'),
        );
      },
    );

    test('does not overwrite existing Authorization header', () async {
      await mockStorage.write(
        key: AuthInterceptor.tokenStorageKey,
        value: 'storage_token',
      );

      final options = RequestOptions(
        path: '/user',
        headers: {'Authorization': 'Bearer custom_token'},
      );
      final handler = _MockRequestInterceptorHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers['Authorization'], equals('Bearer custom_token'));
    });
  });

  group('NetworkErrorInterceptor Tests', () {
    const interceptor = NetworkErrorInterceptor();

    test('maps connection timeout to NetworkException', () {
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );
      final handler = _MockErrorInterceptorHandler();

      interceptor.onError(err, handler);

      expect(handler.rejectedError, isNotNull);
      expect(handler.rejectedError!.error, isA<NetworkException>());
    });

    test('maps 401 response to UnauthorizedException', () {
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
      );
      final handler = _MockErrorInterceptorHandler();

      interceptor.onError(err, handler);

      expect(handler.rejectedError, isNotNull);
      expect(handler.rejectedError!.error, isA<UnauthorizedException>());
    });
  });

  group('DioClient Unit Tests', () {
    test('initializes with config options and interceptor stack', () {
      final config = EnvironmentConfig.dev();
      final mockStorage = MockSecureStorageService();
      final mockLogger = MockLoggerService();

      final client = DioClient(
        config: config,
        secureStorage: mockStorage,
        logger: mockLogger,
      );

      expect(client.dio.options.baseUrl, equals(config.apiBaseUrl));
      expect(client.dio.interceptors.length, greaterThanOrEqualTo(3));
    });
  });
}

class _MockRequestInterceptorHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions requestOptions) {}
}

class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  DioException? rejectedError;

  @override
  void reject(DioException error, [bool callFollowingErrorInterceptor = true]) {
    rejectedError = error;
  }
}
