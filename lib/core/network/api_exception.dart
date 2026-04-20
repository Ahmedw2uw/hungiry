import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiException {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'], code: statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection Timeout");

      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send Timeout");

      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive Timeout");

      case DioExceptionType.badResponse:
        return ApiError(
          message: error.response?.data['message'] ?? "Bad Response",
        );

      case DioExceptionType.cancel:
        return ApiError(message: "Request Cancelled");

      case DioExceptionType.connectionError:
        return ApiError(message: "Connection Error");

      case DioExceptionType.badCertificate:
        return ApiError(message: "Bad Certificate");

      case DioExceptionType.unknown:
        return ApiError(message: "Unknown Error");
    }
  }
}
