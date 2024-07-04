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

      final data = {
        'email': event.email,
        'password': event.password,
      };

      final response = await dio.post(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/signin',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        final token = responseData['token'];
        await secureStorage.write(key: 'token', value: token);

        // Read and print the token
        final storedToken = await secureStorage.read(key: 'token');
        print('Stored Token: $storedToken');

        emit(SignInSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to sign in. Please try again.';
        emit(SignInFailure(error: 'Failed to sign in. Please try again.'));
      }
    } catch (error) {
      if (error is DioError) {
        print('DioError: ${error.toString()}');
        if (error.response != null) {
          print('Error Response Data: ${error.response?.data}');
        }
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(SignInFailure(error: 'Error: $errorMessage'));
      } else {
        print('Error: ${error.toString()}');
        emit(SignInFailure(error: 'Error: ${error.toString()}'));
      }
    }
  }
}
