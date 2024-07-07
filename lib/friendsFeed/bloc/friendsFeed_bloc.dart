import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_event.dart';
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_state.dart';
import 'package:weave_frontend/models/friendsFeedModel.dart';


class FriendPostBloc extends Bloc<FriendPostEvent, FriendPostState> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();


  FriendPostBloc() : super(FriendPostInitial()) {
    on<FetchFriendPosts>(_onFetchFriendPosts);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    print('Stored Token: $storedToken'); // Add this line
    return storedToken;
  }

  Future<void> _onFetchFriendPosts(FetchFriendPosts event, Emitter<FriendPostState> emit) async {
    emit(FriendPostLoading());
    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(FriendPostError('Token is missing'));
      return;
    }
    try {
      final response = await http.post(
        Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/feed/feed/${event.friendId}'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $storedToken',
        },
      );

      print('API Response Status: ${response.statusCode}'); // Debugging
      print('API Response Body: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('responseData $responseData');
        final List<dynamic> postsJson = responseData['data'];
        print('postsJson $postsJson');
        final List<FriendsPost> finalPosts = postsJson.map((json) => FriendsPost.fromJson(json)).toList();
        print('finalPosts $finalPosts');
        emit(FriendPostLoaded(finalPosts));
      } else {
        emit(FriendPostError('Failed to load posts'));
      }
    } catch (e) {
      emit(FriendPostError(e.toString()));
    }
  }
}
