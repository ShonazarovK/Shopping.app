import 'package:dio/dio.dart';

import '../utils/logger.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errorData;
  final StackTrace? stackTrace;

  ServerException({
    required this.message,
    this.statusCode,
    this.errorData,
    this.stackTrace,
  }) {
    _logError();
  }

  void _logError() {
    LoggerService.error(
      'ServerException: $message',
      error: this,
      stackTrace: stackTrace,
      extras: {
        'statusCode': statusCode,
        'errorData': errorData,
      },
    );
  }

  @override
  String toString() {
    return 'ServerException: $message'
        '${statusCode != null ? ' (Status: $statusCode)' : ''}'
        '${errorData != null ? '\nError Data: $errorData' : ''}';
  }

  // JSON formatida xatolikni qaytarish uchun
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'statusCode': statusCode,
      'errorData': errorData,
      'type': 'ServerException',
    };
  }

  // DioError dan ServerException yaratish
  factory ServerException.fromDioError(DioException dioError) {
    try {
      final response = dioError.response;
      final statusCode = response?.statusCode;
      dynamic errorData = response?.data;

      String message = 'Server error occurred';

      if (errorData is Map && errorData['message'] != null) {
        message = errorData['message'].toString();
      } else if (dioError.message != null) {
        message = dioError.message!;
      }

      return ServerException(
        message: message,
        statusCode: statusCode,
        errorData: errorData,
        stackTrace: dioError.stackTrace,
      );
    } catch (e) {
      return ServerException(
        message: 'Failed to parse server error',
        statusCode: 500,
        errorData: {'originalError': e.toString()},
      );
    }
  }
}