import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/userDelete/bloc/deleteUser_event.dart';
import 'package:weave_frontend/userDelete/bloc/deleteUser_state.dart';




class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();
  final String token;


  DeleteUserBloc(this.baseUrl,this.token) : super(DeleteUserInitial()) {
    on<DeleteUserButtonPressed>(_onDeleteUser);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    return storedToken;
  }

  Future<void> _onDeleteUser(
      DeleteUserButtonPressed event, Emitter<DeleteUserState> emit) async {
    emit(DeleteUserLoading());

    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(DeleteUserFailure('Token is missing', error: 'Token is missing'));
      return;
    }

    try {
      final dio = Dio();

      final data = {
        'password': event.password,
      };

      final response = await dio.delete(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/delete',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $storedToken'
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        await secureStorage.deleteAll();

        emit(DeleteUserSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to delete account. Please try again.';
        emit(DeleteUserFailure(errorMessage, error: 'Failed to delete account. Please try again.'));
      }
    } catch (error) {
      if (error is DioError) {
        print('DioError: ${error.toString()}');
        if (error.response != null) {
          print('Error Response Data: ${error.response?.data}');
        }
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(DeleteUserFailure(errorMessage, error: errorMessage));
      } else {
        print('Error: ${error.toString()}');
        emit(DeleteUserFailure('An error occurred. Please try again.', error: 'An error occurred. Please try again.'));
      }
    }
  }
}
