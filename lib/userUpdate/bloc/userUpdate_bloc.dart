import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_event.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_state.dart';


class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();
  final String token;

  UpdateUserBloc(this.baseUrl, this.token) : super(UpdateUserInitial()) {
    on<UpdateUserButtonPressed>(_onUpdateUser);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    return storedToken;
  }

  Future<void> _onUpdateUser(
      UpdateUserButtonPressed event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoading());

    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(UpdateUserFailure('Token is missing'));
      return;
    }

    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'displayName': event.displayName,
        'bio': event.bio,
        if (event.photoURL != null)
          'photoURL': await MultipartFile.fromFile(event.photoURL!.path),
      });

      final response = await dio.put(
        '$baseUrl/api/v1/user/update-user',
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
        emit(UpdateUserSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to update. Please try again.';
        emit(UpdateUserFailure(errorMessage));
      }
    } catch (error) {
      final errorMessage = error is DioError
          ? error.response?.data['message'] ?? 'An error occurred. Please try again.'
          : 'An error occurred. Please try again.';
      emit(UpdateUserFailure(errorMessage));
    }
  }
}
