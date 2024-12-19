import 'exceptions.dart';

abstract class Failure {
  final String message;

  Failure(this.message);

  factory Failure.fromException(Exception exception) {
    switch (exception.runtimeType) {
      case const (ConnectionTimeoutException):
        return NetworkFailure(
            (exception as ConnectionTimeoutException).message);
      case const (ReceiveTimeoutException):
        return NetworkFailure((exception as ReceiveTimeoutException).message);
      case const (ServerErrorException):
        return ServerFailure((exception as ServerErrorException).message);
      case const (RequestCanceledException):
        return NetworkFailure((exception as RequestCanceledException).message);
      case const (ConnectionErrorException):
        return NetworkFailure((exception as ConnectionErrorException).message);
      case const (UnknownErrorException):
        return UnknownFailure((exception as UnknownErrorException).message);
      default:
        return UnknownFailure("An unexpected error occurred.");
    }
  }

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
