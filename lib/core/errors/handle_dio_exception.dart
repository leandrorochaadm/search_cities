import 'package:dio/dio.dart';

import 'exceptions.dart';

class HandleDioException {
  HandleDioException._();

  static Exception call(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeoutException(
          "Connection timeout. Please check your internet.",
        );
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutException(
          "Response timeout. Please try again.",
        );
      case DioExceptionType.badResponse:
        return ServerErrorException(
          "Server error (${exception.response?.statusCode})",
        );
      case DioExceptionType.cancel:
        return RequestCanceledException(
          "Request canceled.",
        );
      case DioExceptionType.connectionError:
        return ConnectionErrorException(
          "Unexpected error: ${exception.message}",
        );
      default:
        return UnknownErrorException(
          "Unknown error occurred.",
        );
    }
  }
}
