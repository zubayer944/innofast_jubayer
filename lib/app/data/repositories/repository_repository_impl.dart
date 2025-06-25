import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/network/api_service.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/repository.dart';
import '../../domain/repositories/repository_repository.dart';


class RepositoryRepositoryImpl implements RepositoryRepository {
  final ApiService apiService;
  final NetworkInfo networkInfo;

  RepositoryRepositoryImpl({
    required this.apiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Repository>>> getUserRepositories(String username, {int page = 1, int perPage = 10}) async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }

    try {
      final result = await apiService.getUserRepositories(username, page: page, perPage: perPage);
      return result;
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
