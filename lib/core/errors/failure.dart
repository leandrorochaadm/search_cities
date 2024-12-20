import 'app_exception.dart';

abstract class Failure {
  final String message;

  Failure(this.message);

  factory Failure.fromException(Exception exception) {
    switch (exception.runtimeType) {
      case const (NetworkException):
        return Failure.network();

      case const (ServerErrorException):
        return Failure.server();

      default:
        return Failure.unknown();
    }
  }

  factory Failure.server(
          [String message = 'Erro no servidor. Tente novamente mais tarde.']) =>
      ServerFailure(message);
  factory Failure.network(
          [String message =
              'Erro na conexão com o servidor. Tente novamente mais tarde.']) =>
      NetworkFailure(message);
  factory Failure.unknown([String message = 'Um erro inesperado ocorreu.']) =>
      UnknownFailure(message);

  @override
  String toString() => "type $runtimeType: message $message";
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
