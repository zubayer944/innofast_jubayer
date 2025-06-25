import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/network/api_service.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/repository.dart';
import '../../domain/repositories/profile_repository.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService apiService;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.apiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }

    try {
      final result = await apiService.getUserProfile('zubayer944');
      return result;
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Repository>>> getUserRepositories(String username) async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }

    try {
      final result = await apiService.getUserRepositories(username);
      return result;
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
