import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/userLogIn/bloc/signIn_event.dart';
import 'package:weave_frontend/userLogIn/bloc/signIn_state.dart';



class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();

  SignInBloc(this.baseUrl) : super(SignInInitial()) {
    on<SignInButtonPressed>(_onSignInUser);
  }

  Future<void> _onSignInUser(
      SignInButtonPressed event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    try {
      final dio = Dio();

      // Create FormData
      FormData formData = FormData.fromMap({
        'email': event.email,
        'password': event.password,
      });

      final response = await dio.post(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/signin',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Save token to secure storage
        await secureStorage.write(key: 'token', value: responseData['token']);

        emit(SignInSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to register. Please try again.';
        emit(SignInFailure(errorMessage, error: 'Failed to register. Please try again.'));
      }
    } catch (error) {
      if (error is DioError) {
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(SignInFailure(errorMessage, error: 'An error occurred. Please try again.'));
      } else {
        emit(SignInFailure('An error occurred. Please try again.', error: 'An error occurred. Please try again.'));
      }
    }
  }
}
