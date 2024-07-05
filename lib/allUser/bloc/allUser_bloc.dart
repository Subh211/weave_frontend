import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
import 'package:weave_frontend/allUser/bloc/allUser_state.dart';
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_event.dart';
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_state.dart';
import 'package:weave_frontend/models/allUser.dart';
import 'package:weave_frontend/models/friendsFeedModel.dart';
import 'package:weave_frontend/models/usersFeedModel.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_event.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_state.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_event.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_state.dart';
import '../../models/postModel.dart';

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





class AlluserBloc extends Bloc<AlluserEvent, AlluserState> {
  AlluserBloc() : super(AlluserStateInitial()) {
    on<GetAllUser>(_onGetAllUser);
  }

  Future<void> _onGetAllUser(GetAllUser event, Emitter<AlluserState> emit) async {
    emit(AlluserStateLoading());
    try {
      final response = await http.get(
        Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/user/alluser'),
      );

      print('API Response Status: ${response.statusCode}'); // Debugging
      print('API Response Body: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('responseData $responseData');
        final List<dynamic> usersJson = responseData['allUser'];
        print('usersJson $usersJson');
        final allusers = usersJson.map((json) => allUserModel.fromJson(json)).toList();
        emit(AlluserStateLoaded(users: allusers));
      } else {
        emit(AlluserStateError(message: "Failed to fetch the users"));
      }
    } catch (e) {
      emit(AlluserStateError(message: e.toString()));
    }
  }
}
