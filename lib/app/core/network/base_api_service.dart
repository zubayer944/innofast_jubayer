import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class BaseApiService {
  final Dio dio;
  final String baseUrl;

  BaseApiService(this.baseUrl) : dio = Dio();

  Future<Either<Failure, Response>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl$path',
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  Future<Either<Failure, Response>> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl$path',
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection timeout occurred');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send timeout occurred');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive timeout occurred');
      case DioExceptionType.badResponse:
        return ServerFailure(
          message: 'Bad response: ${error.response?.statusCode} ${error.response?.statusMessage}'
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return NoInternetFailure();
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Invalid SSL certificate');
      case DioExceptionType.unknown:
        return ServerFailure(message: 'Unknown error occurred: ${error.message}');
    }
  }
}
