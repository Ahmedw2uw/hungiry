import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exception.dart';
import 'package:hungry/core/network/dio_clint.dart';

class ApiServices {
  final DioClint _dioClint = DioClint();
  //! This class will contain all the API services related to the application.
  //* get
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClint.dio.get(endPoint);
      return response.data;
    } on DioException catch (error) {
      // قم بتغيير return إلى throw
      throw ApiException.handleError(error);
    }
  }

  //* post
  // في ملف ApiServices.dart
Future<dynamic> post(String endPoint, dynamic body) async { // تم تغيير النوع هنا إلى dynamic
  try {
    final response = await _dioClint.dio.post(endPoint, data: body);
    return response.data;
  } on DioException catch (error) {
    throw ApiException.handleError(error);
  }
}


  //*put
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClint.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (error) {
      throw ApiException.handleError(error); // تغيير من return إلى throw
    }
  }

  //*delete
  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClint.dio.delete(endPoint, data: body);
      return response.data;
    } on DioException catch (error) {
      throw ApiException.handleError(error); // تغيير من return إلى throw
    }
  }
}
