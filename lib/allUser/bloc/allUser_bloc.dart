// import 'dart:async';
// import 'dart:convert';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
// import 'package:weave_frontend/allUser/bloc/allUser_state.dart';
// import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_event.dart';
// import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_state.dart';
// import 'package:weave_frontend/models/allUser.dart';
// import 'package:weave_frontend/models/friendsFeedModel.dart';
// import 'package:weave_frontend/models/usersFeedModel.dart';
// import 'package:weave_frontend/userSinglePost/bloc/singlePost_event.dart';
// import 'package:weave_frontend/userSinglePost/bloc/singlePost_state.dart';
// import 'package:weave_frontend/usersFeed/bloc/usersFeed_event.dart';
// import 'package:weave_frontend/usersFeed/bloc/usersFeed_state.dart';
// import '../../models/postModel.dart';

// class AlluserBloc extends Bloc<AlluserEvent, AlluserState> {
//
//   AlluserBloc() : super(AlluserStateInitial()) {
//     on<GetAllUser>(_onGetAllUser);
//   }
//
//   Future<List<allUserModel>> _onGetAllUser(GetAllUser event, Emitter<AlluserState> emit) async {
//     emit(AlluserStateLoading());
//     try {
//       final response = await http.get(
//         Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/user/alluser'),
//       );
//
//       print('API Response Status: ${response.statusCode}'); // Debugging
//       print('API Response Body: ${response.body}'); // Debugging
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         print('responseData $responseData');
//         final List<dynamic> postsJson = responseData['allUser'];
//         print('postsJson $postsJson');
//         final allusers = postsJson.map((json) => allUserModel.fromJson(json)).toList();
//         emit(AlluserStateLoaded(users: allusers));
//       } else {
//         emit(AlluserStateError(message: "Failed to fetch the users"));
//       }
//     } catch (e) {
//       emit(AlluserStateError(message: e.toString()));
//     }
//   }
// }




















//
// class AlluserBloc extends Bloc<AlluserEvent, AlluserState> {
//   List<allUserModel> allusers = [];
//
//
//   AlluserBloc() : super(AlluserStateInitial()) {
//     on<GetAllUser>(_onGetAllUser);
//     on<SearchAllUser>(_onSearchAllUser);
//   }
//
//   Future<void> _onGetAllUser(GetAllUser event, Emitter<AlluserState> emit) async {
//     emit(AlluserStateLoading());
//     try {
//       final response = await http.get(
//         Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/user/alluser'),
//       );
//
//       print('API Response Status: ${response.statusCode}'); // Debugging
//       print('API Response Body: ${response.body}'); // Debugging
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         print('responseData $responseData');
//         final List<dynamic> usersJson = responseData['allUser'];
//         print('usersJson $usersJson');
//         final allusers = usersJson.map((json) => allUserModel.fromJson(json)).toList();
//         //final _users = usersJson.map((json) => allUserModel.fromJson(json)).toList();
//         emit(AlluserStateLoaded(users: allusers));
//       } else {
//         emit(AlluserStateError(message: "Failed to fetch the users"));
//       }
//     } catch (e) {
//       emit(AlluserStateError(message: e.toString()));
//     }
//   }
//
//   // Future<void> _onSearchAllUser(SearchAllUser event, Emitter<AlluserState> emit) async {
//   //   final SearchTerm = event.searchTerm.toLowerCase();
//   //   print("searchterm $SearchTerm");
//   //   print('_users $allusers');
//   //   // final filteredArticles = await _articles.where((article) {
//   //   //   final title = article['title']?.toLowerCase() ?? '';
//   //   //   return title.contains(SearchTerm);
//   //   // }).toList();
//   //   // emit(NewsLoaded(articles: filteredArticles));
//   //   final filteredUsers = await allusers.where((users) {
//   //     final finalUser = users.displayName.toLowerCase() ?? '';
//   //     return finalUser.contains(SearchTerm);
//   //   }).toList();
//   //   print("finaluser $filteredUsers");
//   //   emit(AlluserStateLoaded(users: filteredUsers));
//   // }
//   Future<void> _onSearchAllUser(SearchAllUser event, Emitter<AlluserState> emit) async {
//     final searchTerm = event.searchTerm.toLowerCase();
//     print("Search term: $searchTerm");
//     print('Users before search: $allusers');
//     final filteredUsers = allusers.where((user) {
//       final displayName = user.displayName.toLowerCase();
//       return displayName.contains(searchTerm);
//     }).toList();
//     print("Filtered users: $filteredUsers");
//     emit(AlluserStateLoaded(users: filteredUsers));
//   }
//   }

















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






