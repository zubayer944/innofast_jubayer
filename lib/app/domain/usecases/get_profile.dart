import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, Profile>> call() async {
    return repository.getProfile();
  }
}
