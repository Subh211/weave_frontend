import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:weave_frontend/userSignUp/bloc/registration_event.dart';
import 'package:weave_frontend/userSignUp/bloc/registration_state.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_event.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_state.dart';



class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final CookieJar cookieJar = CookieJar();
  final String token;


  UpdateUserBloc(this.baseUrl,this.token) : super(UpdateUserInitial()) {
    on<UpdateUserButtonPressed>(_onUpdateUser);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    print('Stored Token: $storedToken'); // Add this line
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

      // Create FormData
      Map<String, dynamic> formDataMap = {
        'displayName': event.displayName,
      };

      if (event.photoURL != null) {
        formDataMap['photoURL'] = await MultipartFile.fromFile(event.photoURL!.path);
      }

      FormData formData = FormData.fromMap(formDataMap);


      final response = await dio.put(
        'https://weave-backend-pyfu.onrender.com/api/v1/user/update-user',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            HttpHeaders.authorizationHeader: 'Bearer $storedToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data.user;

        print('response: $response ');
        print('responsedata: $responseData');

        // Save token to secure storage
        await secureStorage.write(key: 'token', value: responseData['token']);

        emit(UpdateUserSuccess(responseData['message']));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to update. Please try again.';
        emit(UpdateUserFailure(errorMessage));
      }
    } catch (error) {
      if (error is DioError) {
        print('Error: ${error.toString()}');
        final errorMessage = error.response?.data['message'] ?? 'An error occurred. Please try again.';
        emit(UpdateUserFailure(errorMessage));
      } else {
        print('Error: ${error.toString()}');
        emit(UpdateUserFailure('An error occurred. Please try again.'));
      }
    }
  }
}

