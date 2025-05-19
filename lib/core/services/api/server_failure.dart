import 'package:dio/dio.dart';

class ServerFailure {
  final String message;
  final String error;
  final int statusCode;

  const ServerFailure({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  // Factory method to handle responses from the server
  factory ServerFailure.fromResponse(Map<String, dynamic> response) {
    final dynamic message = response['message'];
    final String error = response['error'] ?? 'Unknown Error';
    final int statusCode = response['statusCode'] ?? 500;

    if (message is List) {
      // Map specific error messages in lists
      if (message.any(
          (m) => m.toString().contains('phone must be a valid phone number'))) {
        return ServerFailure(
          message: 'errors.invalid_phone',
          error: error,
          statusCode: statusCode,
        );
      }
      return ServerFailure(
        message: 'errors.bad_request',
        error: error,
        statusCode: statusCode,
      );
    } else if (message is String) {
      // Map specific string messages
      if (message.contains('not found')) {
        return ServerFailure(
          message: 'errors.not_found',
          error: error,
          statusCode: 404,
        );
      }
      if (statusCode == 401) {
        return ServerFailure(
          message: 'errors.unauthorized',
          error: error,
          statusCode: 401,
        );
      }
      return ServerFailure(
        message: 'errors.unknown_error',
        error: error,
        statusCode: statusCode,
      );
    }

    return ServerFailure(
      message: 'errors.unknown_error',
      error: error,
      statusCode: statusCode,
    );
  }

  // Factory method to handle Dio exceptions
  static ServerFailure fromDioException(DioException exception) {
    final response = exception.response?.data;

    // Attempt to parse the server response
    if (response is Map<String, dynamic>) {
      return ServerFailure.fromResponse(response);
    }

    // Handle Dio-specific exceptions
    switch (exception.type) {
      case DioExceptionType.cancel:
        return ServerFailure(
          message: 'errors.request_cancelled',
          error: 'Request Cancelled',
          statusCode: 499,
        );
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          message: 'errors.connection_timeout',
          error: 'Connection Timeout',
          statusCode: 408,
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          message: 'errors.receive_timeout',
          error: 'Receive Timeout',
          statusCode: 408,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          message: 'errors.send_timeout',
          error: 'Send Timeout',
          statusCode: 408,
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          message: 'errors.no_internet',
          error: 'Connection Error',
          statusCode: 503,
        );
      default:
        return ServerFailure(
          message: 'errors.unknown_error',
          error: exception.response?.statusMessage ?? 'Unknown Error',
          statusCode: exception.response?.statusCode ?? 500,
        );
    }
  }

  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() =>
      'Error: $error, Message: $message, StatusCode: $statusCode';

}
