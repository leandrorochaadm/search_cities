import 'package:dio/dio.dart';

import 'app_exception.dart';

class HandleDioException {
  HandleDioException._();

  static Exception call(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(
          "Connection timeout. Please check your internet.",
        );
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          "Response timeout. Please try again.",
        );
      case DioExceptionType.badResponse:
        return ServerErrorException(
          "Server error (${exception.response?.statusCode})",
        );
      case DioExceptionType.cancel:
        return NetworkException(
          "Request canceled.",
        );
      case DioExceptionType.sendTimeout:
        return NetworkException(
          "Request send Timeout.",
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          "Unexpected error: ${exception.message}",
        );
      default:
        return UnknownErrorException(
          "Unknown error occurred.",
        );
    }
  }
}
