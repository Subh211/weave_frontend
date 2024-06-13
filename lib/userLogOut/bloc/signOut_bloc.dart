import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/userLogOut/bloc/signOut_event.dart';
import 'package:weave_frontend/userLogOut/bloc/signOut_state.dart';



class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();
  final String token;


  SignOutBloc(this.baseUrl, this.token) : super(SignOutInitial()) {
    on<SignOutButtonPressed>(_onSignOutUser);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    print('Stored Token: $storedToken'); // Add this line
    return storedToken;
  }

  Future<void> _onSignOutUser(
      SignOutButtonPressed event, Emitter<SignOutState> emit) async {
    emit(SignOutLoading());

    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(SignOutFailure('Token is missing', error: 'Token is missing'));
      return;
    }

    try {
      final dio = Dio();


      final response = await dio.get(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/logout',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $storedToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Delete all token of secure storage
        await secureStorage.deleteAll();

        emit(SignOutSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to sign out. Please try again.';
        emit(SignOutFailure(errorMessage, error: 'Failed to sign out. Please try again.'));
      }
    } catch (error) {
      if (error is DioError) {
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(SignOutFailure(errorMessage, error: 'An error occurred. Please try again.'));
      } else {
        emit(SignOutFailure('An error occurred. Please try again.', error: 'An error occurred. Please try again.'));
      }
    }
  }
}
