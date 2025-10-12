import 'package:desafio_loomi/data/model/movie_model.dart';
import 'package:desafio_loomi/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  final Dio _dio;
  static const String baseUrl = 'https://untold-strapi.api.prod.loomi.com.br/api';

  ApiService() : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final token = await user.getIdToken();
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required String firebaseUid,
  }) async {
    try {
      await _dio.post('/auth/local/register', data: {
        'username': username,
        'email': email,
        'password': password,
        'firebase_UID': firebaseUid,
      });
    } catch (e) {
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }

  Future<void> updateOnboarding() async {
    try {
      await _dio.patch('/users/updateMe', data: {
        'data': {
          'finished_onboarding': true
        }
      });
    } catch (e) {
      throw Exception('Failed to update onboarding: ${e.toString()}');
    }
  }

  Future<UserModel> getUserData() async {
    try {
      final response = await _dio.get('/users/me');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get user data: ${e.toString()}');
    }
  }

  Future<void> updateUser({required String username}) async {
  try {
    await _dio.patch('/users/updateMe', data: {
      'data': {
        'username': username,
      }
    });
  } catch (e) {
    throw Exception('Failed to update user: ${e.toString()}');
  }
}

 Future<List<MovieModel>> getMovies() async {
    try {
      final response = await _dio.get('/movies?populate=poster');
      final List data = response.data['data'] ?? [];
      return data.map((json) {
        final attributes = json['attributes'] ?? {};
        return MovieModel(
          id: json['id'] ?? 0,
          title: attributes['title'] ?? '',
          description: attributes['description'] ?? '',
          genre: attributes['genre'] ?? '',
          posterUrl: attributes['poster']?['data']?['attributes']?['url'] ?? '',
          availableUntil: attributes['available_until'] ?? '',
          commentsCount: attributes['comments_count'] ?? 0,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch movies: ${e.toString()}');
    }
  }
}