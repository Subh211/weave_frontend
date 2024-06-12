import 'dart:async';
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

  DeleteUserBloc(this.baseUrl) : super(DeleteUserInitial()) {
    on<DeleteUserButtonPressed>(_onDeleteUser);
  }

  Future<void> _onDeleteUser(
      DeleteUserButtonPressed event, Emitter<DeleteUserState> emit) async {
    emit(DeleteUserLoading());
    try {
      final dio = Dio();

      // Create FormData
      FormData formData = FormData.fromMap({
        'password': event.password,
      });

      final response = await dio.post(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/delete',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

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
