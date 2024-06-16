import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:weave_frontend/userAddPost/bloc/addPost_event.dart';
import 'package:weave_frontend/userAddPost/bloc/addPost_state.dart';


class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();
  final String token;

  AddPostBloc(this.baseUrl, this.token) : super(AddPostInitial()) {
    on<AddPostButtonPressed>(_onAddUser);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    return storedToken;
  }

  Future<void> _onAddUser(
      AddPostButtonPressed event, Emitter<AddPostState> emit) async {
    emit(AddPostLoading());

    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(AddPostFailure('Token is missing'));
      return;
    }

    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'caption': event.caption,
        if (event.image != null)
          'image': await MultipartFile.fromFile(event.image!.path),
      });

      final response = await dio.post(
        '$baseUrl/api/v1/post',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            HttpHeaders.authorizationHeader: 'Bearer $storedToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        emit(AddPostSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to update. Please try again.';
        emit(AddPostFailure(errorMessage));
      }
    } catch (error) {
      final errorMessage = error is DioError
          ? error.response?.data['message'] ?? 'An error occurred. Please try again.'
          : 'An error occurred. Please try again.';
      emit(AddPostFailure(errorMessage));
    }
  }
}
