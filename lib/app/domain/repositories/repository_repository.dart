import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/repository.dart';

abstract class RepositoryRepository {
  Future<Either<Failure, List<Repository>>> getUserRepositories(String username, {int page, int perPage});
}
