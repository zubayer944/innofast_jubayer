import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../config/app_config.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/repository.dart';
import '../error/failures.dart';
import 'base_api_service.dart';

class ApiService extends BaseApiService {
  static ApiService get to => Get.find<ApiService>();
  @override
  String baseUrl = AppConfig().baseUrl;

  ApiService() : super(AppConfig().baseUrl) {
    _setupDio();
  }

  void _setupDio() {
    super.dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'Jubayer-Innofast',
      },
    );

    super.dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ));
  }

  Future<Either<Failure, Profile>> getUserProfile(String username) {
    return get('users/$username').then((result) {
      return result.fold(
        (failure) => Left(failure),
        (response) => Right(Profile.fromJson(response.data)),
      );
    });
  }

  Future<Either<Failure, List<Repository>>> getUserRepositories(String username, {int page = 1, int perPage = 10}) {
    return get('users/$username/repos', queryParameters: {
      'page': page,
      'per_page': perPage,
    }).then((result) {
      return result.fold(
        (failure) => Left(failure),
        (response) => Right((response.data as List)
            .map((item) => Repository.fromJson(item as Map<String, dynamic>))
            .toList()),
      );
    });
  }
}
