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
      return _handleListMessage(message, error, statusCode);
    } else if (message is String) {
      return _handleStringMessage(message, error, statusCode);
    }

    return ServerFailure(
      message: 'errors.unknown_error',
      error: error,
      statusCode: statusCode,
    );
  }

  // Handle list messages with specific error mapping
  static ServerFailure _handleListMessage(
    List message,
    String error,
    int statusCode,
  ) {
    final messageString = message.join(', ').toLowerCase();

    // Phone validation errors
    if (messageString.contains('phone must be a valid phone number') ||
        messageString.contains('phone number')) {
      return ServerFailure(
        message: 'errors.invalid_phone',
        error: error,
        statusCode: statusCode,
      );
    }

    // Email validation errors
    if (messageString.contains('email must be') ||
        messageString.contains('valid email') ||
        messageString.contains('email is not valid')) {
      return ServerFailure(
        message: 'errors.invalid_email',
        error: error,
        statusCode: statusCode,
      );
    }

    // Password validation errors
    if (messageString.contains('password') &&
        messageString.contains('strong')) {
      return ServerFailure(
        message: 'errors.weak_password',
        error: error,
        statusCode: statusCode,
      );
    }

    if (messageString.contains('password') && messageString.contains('match')) {
      return ServerFailure(
        message: 'errors.password_mismatch',
        error: error,
        statusCode: statusCode,
      );
    }

    // Required field errors
    if (messageString.contains('should not be empty') ||
        messageString.contains('is required')) {
      return ServerFailure(
        message: 'errors.required_fields',
        error: error,
        statusCode: statusCode,
      );
    }

    // Generic bad request
    return ServerFailure(
      message: 'errors.bad_request',
      error: error,
      statusCode: statusCode,
    );
  }

  // Handle string messages with status code mapping
  static ServerFailure _handleStringMessage(
    String message,
    String error,
    int statusCode,
  ) {
    final lowerMessage = message.toLowerCase();

    // Status code based errors
    switch (statusCode) {
      case 400:
        return _handle400Error(lowerMessage, error, statusCode);
      case 401:
        return ServerFailure(
          message: 'errors.unauthorized',
          error: error,
          statusCode: 401,
        );
      case 403:
        return ServerFailure(
          message: 'errors.forbidden',
          error: error,
          statusCode: 403,
        );
      case 404:
        return ServerFailure(
          message: 'errors.not_found',
          error: error,
          statusCode: 404,
        );
      case 409:
        return _handle409Error(lowerMessage, error, statusCode);
      case 422:
        return ServerFailure(
          message: 'errors.validation_error',
          error: error,
          statusCode: 422,
        );
      case 429:
        return ServerFailure(
          message: 'errors.too_many_requests',
          error: error,
          statusCode: 429,
        );
      case 500:
        return ServerFailure(
          message: 'errors.server_error',
          error: error,
          statusCode: 500,
        );
      case 503:
        return ServerFailure(
          message: 'errors.service_unavailable',
          error: error,
          statusCode: 503,
        );
    }

    // Message content based errors
    if (lowerMessage.contains('not found')) {
      return ServerFailure(
        message: 'errors.not_found',
        error: error,
        statusCode: statusCode,
      );
    }

    if (lowerMessage.contains('unauthorized') ||
        lowerMessage.contains('authentication')) {
      return ServerFailure(
        message: 'errors.unauthorized',
        error: error,
        statusCode: 401,
      );
    }

    if (lowerMessage.contains('token') && lowerMessage.contains('expired')) {
      return ServerFailure(
        message: 'errors.token_expired',
        error: error,
        statusCode: 401,
      );
    }

    if (lowerMessage.contains('invalid credentials') ||
        lowerMessage.contains('wrong password') ||
        lowerMessage.contains('incorrect password') ||
        lowerMessage.contains('invalid request')) {
      return ServerFailure(
        message: 'errors.invalid_credentials',
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

  // Handle 400 Bad Request specific errors
  static ServerFailure _handle400Error(
    String message,
    String error,
    int statusCode,
  ) {
    if (message.contains('invalid') && message.contains('phone')) {
      return ServerFailure(
        message: 'errors.invalid_phone',
        error: error,
        statusCode: statusCode,
      );
    }

    if (message.contains('invalid') && message.contains('email')) {
      return ServerFailure(
        message: 'errors.invalid_email',
        error: error,
        statusCode: statusCode,
      );
    }

    return ServerFailure(
      message: 'errors.bad_request',
      error: error,
      statusCode: statusCode,
    );
  }

  // Handle 409 Conflict errors
  static ServerFailure _handle409Error(
    String message,
    String error,
    int statusCode,
  ) {
    if (message.contains('already exists') ||
        message.contains('duplicate') ||
        message.contains('already registered')) {
      return ServerFailure(
        message: 'errors.already_exists',
        error: error,
        statusCode: statusCode,
      );
    }

    return ServerFailure(
      message: 'errors.conflict',
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
        return const ServerFailure(
          message: 'errors.request_cancelled',
          error: 'Request Cancelled',
          statusCode: 499,
        );

      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          message: 'errors.connection_timeout',
          error: 'Connection Timeout',
          statusCode: 408,
        );

      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          message: 'errors.receive_timeout',
          error: 'Receive Timeout',
          statusCode: 408,
        );

      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          message: 'errors.send_timeout',
          error: 'Send Timeout',
          statusCode: 408,
        );

      case DioExceptionType.connectionError:
        return const ServerFailure(
          message: 'errors.no_internet',
          error: 'No Internet Connection',
          statusCode: 503,
        );

      case DioExceptionType.badCertificate:
        return const ServerFailure(
          message: 'errors.security_error',
          error: 'Security Certificate Error',
          statusCode: 495,
        );

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode ?? 500;
        return ServerFailure(
          message: _getMessageByStatusCode(statusCode),
          error: exception.response?.statusMessage ?? 'Bad Response',
          statusCode: statusCode,
        );

      case DioExceptionType.unknown:
        // Check if it's a network error
        final errorString = exception.error.toString();
        if (errorString.contains('SocketException') ||
            errorString.contains('Network')) {
          return const ServerFailure(
            message: 'errors.no_internet',
            error: 'Network Error',
            statusCode: 503,
          );
        }

        return ServerFailure(
          message: 'errors.unknown_error',
          error: exception.message ?? 'Unknown Error',
          statusCode: exception.response?.statusCode ?? 500,
        );
    }
  }

  // Get appropriate error message based on status code
  static String _getMessageByStatusCode(int statusCode) {
    if (statusCode >= 500) {
      return 'errors.server_error';
    } else if (statusCode == 401) {
      return 'errors.unauthorized';
    } else if (statusCode == 403) {
      return 'errors.forbidden';
    } else if (statusCode == 404) {
      return 'errors.not_found';
    } else if (statusCode == 400) {
      return 'errors.bad_request';
    } else if (statusCode == 409) {
      return 'errors.conflict';
    } else {
      return 'errors.unknown_error';
    }
  }

  // Helper getters
  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
  bool get isBadRequest => statusCode == 400;
  bool get isServerError => statusCode >= 500;
  bool get isNetworkError => statusCode == 503;
  bool get isValidationError => statusCode == 422;

  // Get user-friendly message (for display)
  String getUserMessage() => message;

  @override
  String toString() =>
      'ServerFailure(error: $error, message: $message, statusCode: $statusCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServerFailure &&
        other.message == message &&
        other.error == error &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ error.hashCode ^ statusCode.hashCode;
}
