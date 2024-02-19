import 'package:dio/dio.dart';

class AuthService {
  static BaseOptions options = BaseOptions(
    baseUrl: "http://localhost:8080/api/auth",
  );
  final Dio _dio = Dio(options);

  Future<dynamic> registerUser(Map<String, dynamic>? userData) async {
    try {
      Response response = await _dio.post(
        '/register', //ENDPONT URL
        data: userData, //REQUEST BODY
      );
      //returns the successful json object
      return response.data;
    } on DioException catch (e) {
      //returns the error object if there is
      return e.response!.data;
    }
  }

  Future<dynamic> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        '/login',
        data: {'username': username, 'password': password},
      );
      //returns the successful user data json object
      return response.data;
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  // Future<Response> logout() async {
  //     //IMPLEMENT USER LOGOUT
  //  }
}
