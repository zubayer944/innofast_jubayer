import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/profile.dart';
import '../entities/repository.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, List<Repository>>> getUserRepositories(String username);
  // Future<Either<Failure, void>> updateProfile(Profile profile);
}
