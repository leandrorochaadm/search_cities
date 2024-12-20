// Exceções customizadas

abstract class AppException implements Exception {}

class NetworkException implements AppException {
  final String message;
  NetworkException(this.message);
}

class ServerErrorException implements AppException {
  final String message;
  ServerErrorException(this.message);
}

class UnknownErrorException implements AppException {
  final String message;
  UnknownErrorException(this.message);
}
