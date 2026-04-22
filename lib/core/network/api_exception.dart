import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiException {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // --- اللمسة المطلوبة هنا ---
    // إذا كان الرد عبارة عن صفحة HTML (بسبب خطأ 500 في السيرفر)
    if (data is String && data.contains('<!DOCTYPE html>')) {
      return ApiError(
        message: "Server Error (500): Please try again later",
        code: statusCode,
      );
    }
    // -------------------------

    // 1. فحص أولي آمن للبيانات
    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'].toString(), code: statusCode);
    }

    print(statusCode);
    print(data);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection Timeout", code: statusCode);
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send Timeout", code: statusCode);
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive Timeout", code: statusCode);

      case DioExceptionType.badResponse:
        String errorMessage = "Bad Response";

        if (data is Map<String, dynamic>) {
          errorMessage = data['message']?.toString() ?? "Error $statusCode";
        } else if (data is List && data.isNotEmpty) {
          errorMessage = data[0].toString();
        } else if (data != null) {
          // إذا لم يكن HTML وكان نصاً عادياً، نعرضه
          errorMessage = data.toString();
        }

        return ApiError(message: errorMessage, code: statusCode);

      case DioExceptionType.cancel:
        return ApiError(message: "Request Cancelled", code: statusCode);
      case DioExceptionType.connectionError:
        return ApiError(message: "No Internet Connection", code: statusCode);
      case DioExceptionType.badCertificate:
        return ApiError(message: "Bad Certificate", code: statusCode);
      case DioExceptionType.unknown:
      default:
        return ApiError(message: "Something went wrong", code: statusCode);
    }
  }
}
