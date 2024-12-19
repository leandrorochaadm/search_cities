// Exceções customizadas
class ConnectionTimeoutException implements Exception {
  final String message;
  ConnectionTimeoutException(this.message);
}

class ReceiveTimeoutException implements Exception {
  final String message;
  ReceiveTimeoutException(this.message);
}

class ServerErrorException implements Exception {
  final String message;
  ServerErrorException(this.message);
}

class RequestCanceledException implements Exception {
  final String message;
  RequestCanceledException(this.message);
}

class ConnectionErrorException implements Exception {
  final String message;
  ConnectionErrorException(this.message);
}

class UnknownErrorException implements Exception {
  final String message;
  UnknownErrorException(this.message);
}
