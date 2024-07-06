import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
import 'package:weave_frontend/allUser/bloc/allUser_state.dart';
import 'package:weave_frontend/models/allUser.dart';

class AlluserBloc extends Bloc<AlluserEvent, AlluserState> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  List<allUserModel> allusers = [];

  AlluserBloc() : super(AlluserStateInitial()) {
    on<GetAllUser>(_onGetAllUser);
    on<SearchAllUser>(_onSearchAllUser);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    print('Stored Token: $storedToken'); // Add this line
    return storedToken;
  }

  Future<void> _onGetAllUser(GetAllUser event, Emitter<AlluserState> emit) async {
    emit(AlluserStateLoading());
    try {
      final token = await _getStoredToken();

      final response = await http.get(
        Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/user/alluser'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('API Response Status: ${response.statusCode}'); // Debugging
      print('API Response Body: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Response Data: $responseData');
        final List<dynamic> usersJson = responseData['allUser'];
        print('Users JSON: $usersJson');
        allusers = usersJson.map((json) => allUserModel.fromJson(json)).toList();
        emit(AlluserStateLoaded(users: allusers));
      } else {
        emit(AlluserStateError(message: "Failed to fetch the users"));
      }
    } catch (e) {
      emit(AlluserStateError(message: e.toString()));
    }
  }

  Future<void> _onSearchAllUser(SearchAllUser event, Emitter<AlluserState> emit) async {
    emit(AlluserStateLoading());
    try {
      final token = await _getStoredToken();

      final response = await http.get(
        Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/user/alluser'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('API Response Status: ${response.statusCode}'); // Debugging
      print('API Response Body: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Response Data: $responseData');
        final List<dynamic> usersJson = responseData['allUser'];
        print('Users JSON: $usersJson');
        allusers = usersJson.map((json) => allUserModel.fromJson(json)).toList();

        final searchTerm = event.searchTerm.toLowerCase();
        print("Search Term: $searchTerm");
        print('Users before search: $allusers');

        final filteredUsers = allusers.where((user) {
          final displayName = user.displayName.toLowerCase();
          return displayName.contains(searchTerm);
        }).toList();

        print("Filtered Users: $filteredUsers");
        emit(AlluserStateLoaded(users: filteredUsers));
      } else {
        emit(AlluserStateError(message: "Failed to fetch the users"));
      }
    } catch (e) {
      emit(AlluserStateError(message: e.toString()));
    }
  }
}






