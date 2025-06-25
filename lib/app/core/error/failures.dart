import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

class NoInternetFailure extends Failure {
  static const String defaultMessage = 'No internet connection available';
  
  const NoInternetFailure() : super(message: defaultMessage);
}
