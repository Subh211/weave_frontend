import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();

  RegistrationBloc(this.baseUrl) : super(RegistrationInitial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    try {
      final dio = Dio();

      // Create FormData
      FormData formData = FormData.fromMap({
        'email': event.email,
        'name': event.name,
        'password': event.password,
        'confirmPassword': event.confirmPassword,
        'displayName': event.displayName,
        'bio': event.bio,
        if (event.photoURL != null)
          'photoURL': await MultipartFile.fromFile(event.photoURL!.path),
      });

      final response = await dio.post(
        '$baseUrl/api/v1/user/register',
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

        emit(RegistrationSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to register. Please try again.';
        emit(RegistrationFailure(errorMessage));
      }
    } catch (error) {
      if (error is DioError) {
        print('DioError: ${error.toString()}');
        if (error.response != null) {
          print('Error Response Data: ${error.response?.data}');
        }
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(RegistrationFailure(errorMessage));
      } else {
        print('Error: ${error.toString()}');
        emit(RegistrationFailure('An error occurred. Please try again.'));
      }
    }
  }
}

