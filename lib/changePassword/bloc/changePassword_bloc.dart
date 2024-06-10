import 'dart:async';
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

  ChangePasswordBloc(this.baseUrl) : super(ChangePasswordInitial()) {
    on<ChangePasswordButtonPressed>(_onChangePassword);
  }

  Future<void> _onChangePassword(
      ChangePasswordButtonPressed event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    try {
      final dio = Dio();

      // Create FormData
      FormData formData = FormData.fromMap({
        'oldPassword': event.oldPassword,
        'newPassword': event.newPassword,
      });

      final response = await dio.post(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/change-password',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        emit(ChangePasswordSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to change password. Please try again.';
        emit(ChangePasswordFailure(errorMessage, error: 'Failed to change password. Please try again.'));
      }
    } catch (error) {
      if (error is DioError) {
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(ChangePasswordFailure(errorMessage, error: 'An error change password. Please try again.'));
      } else {
        emit(ChangePasswordFailure('An error occurred. Please try again.', error: 'An error occurred. Please try again.'));
      }
    }
  }
}
