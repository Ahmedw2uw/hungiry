import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exception.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/pref_helpers.dart';
import 'package:hungry/fetures/auth/data/user_model.dart';

class AuthRepo {
  ApiServices apiServices = ApiServices(); // to call api services
  //(login, register, logout, get user data, update user data, change password, forget password)

  //!1 Login
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiServices.post('/login', {
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];
        if (code != 200 || data == null) {
          throw ApiError(message: msg, code: code);
        }
        final user = UserModel.fromjson(response['data']);

        if (user.token != null) {
          await PrefHelpers.saveToken(user.token!);
          return user;
        } else {
          throw ApiError(message: 'Invalid response from server');
        }
      } else {
        throw ApiError(message: 'Unexpected response format');
      }
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //!2 Register

  

  //!3 Logout

  //!4 Get user data


  //!5 Update user data

  //!6 Change password

  //!7 Forget password
}
