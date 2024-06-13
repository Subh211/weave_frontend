import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/changePassword/bloc/changePassword_event.dart';
import 'package:weave_frontend/changePassword/bloc/changePassword_state.dart';




class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();
  final String token;

  ChangePasswordBloc(this.baseUrl,this.token) : super(ChangePasswordInitial()) {
    on<ChangePasswordButtonPressed>(_onChangePassword);
  }

  // // Method to get the stored token
  // Future<String?> _getStoredToken() async {
  //   return await secureStorage.read(key: 'token');
  // }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    print('Stored Token: $storedToken'); // Add this line
    return storedToken;
  }


  Future<void> _onChangePassword(
      ChangePasswordButtonPressed event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(ChangePasswordFailure('Token is missing', error: 'Token is missing'));
      return;
    }
    try {
      final dio = Dio();
      final data = {
        'oldPassword': event.oldPassword,
        'newPassword': event.newPassword,
      };

      final response = await dio.post(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/change-password',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $storedToken',
          },
        ),
      );

      print('storedToken $storedToken');

      if (response.statusCode == 200) {
        final responseData = response.data;

        emit(ChangePasswordSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to change password. Please try again.';
        emit(ChangePasswordFailure(errorMessage, error: 'Failed to change password. Please try again.'));
      }
    } catch (error) {
      if (error is DioError) {
        print('DioError: ${error.toString()}');
        if (error.response != null) {
          print('Error Response Data: ${error.response?.data}');
        }
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(ChangePasswordFailure(errorMessage, error: errorMessage));
      } else {
        print('Error: ${error.toString()}');
        emit(ChangePasswordFailure('An error occurred. Please try again.', error: 'An error occurred. Please try again.'));
      }
    }
  }
}


