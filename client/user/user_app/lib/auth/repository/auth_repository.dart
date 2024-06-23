import 'package:dio/dio.dart';

class AuthRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:5000'));

  Future<String?> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      print('Login response: ${response.data}');
      return response.data['user_id'];
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    try {
      final response = await dio.get(
        '/auth/profile',
        queryParameters: {'user_id': userId},
      );
      print('Fetch profile response: ${response.data}');
      return response.data;
    } catch (e) {
      print('Fetch profile error: $e');
      return null;
    }
  }
}



// import 'package:dio/dio.dart';

// class AuthRepository {
//   final Dio dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:5000'));

//   Future<bool> login(String email, String password) async {
//     try {
//       final response = await dio.post(
//         '/auth/login',
//         data: {'email': email, 'password': password},
//       );
//       // Assuming the API returns a boolean value for success
//       return response.data['success'];
//     } catch (e) {
//       // Handle login error
//       return false;
//     }
//   }

//   Future<Map<String, dynamic>?> fetchProfile() async {
//     try {
//       final response = await dio.get('/auth/profile');
//       return response.data;
//     } catch (e) {
//       // Handle fetch profile error
//       return null;
//     }
//   }
// }









// // lib/auth/repository/auth_repository.dart

// import 'package:dio/dio.dart';
// import 'package:user_app/core/network/dio_client.dart';

// class AuthRepository {
//   Future<bool> login(String email, String password) async {
//     try {
//       final response = await dio.post('/auth/login', data: {
//         'email': email,
//         'password': password,
//       });

//       if (response.statusCode == 200) {
//         // If login is successful, you can store the token or handle the response accordingly
//         // For now, just return true indicating success
//         return true;
//       } else {
//         // Handle error response
//         print('Login failed with status: ${response.statusCode}');
//         return false;
//       }
//     } catch (e) {
//       print('Login error: $e');
//       return false;
//     }
//   }
// }
