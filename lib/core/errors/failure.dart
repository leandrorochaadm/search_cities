abstract class Failure {
  final String message;

  Failure(this.message);

  factory Failure.server({required String message}) => ServerFailure(message);
  factory Failure.network({required String message}) => NetworkFailure(message);
  factory Failure.unknown({required String message}) => UnknownFailure(message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}
