import 'package:dio/dio.dart';
import 'package:hungry/core/utils/pref_helpers.dart';

class DioClint {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://sonic-zdi0.onrender.com/api",
      headers: {'Content-Type': 'application/json'},
    ),
  );

  DioClint() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handuler) async {
          final token = await PrefHelpers.getToken(); //? from pref helper
          options.headers['Authorization'] = 'Bearer $token';
          return handuler.next(options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
