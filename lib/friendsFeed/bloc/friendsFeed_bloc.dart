import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_event.dart';
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_state.dart';
import 'package:weave_frontend/models/friendsFeedModel.dart';
import 'package:weave_frontend/models/usersFeedModel.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_event.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_state.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_event.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_state.dart';
import '../../models/postModel.dart';

class FriendPostBloc extends Bloc<FriendPostEvent, FriendPostState> {

  FriendPostBloc() : super(FriendPostInitial()) {
    on<FetchFriendPosts>(_onFetchFriendPosts);
  }

  Future<void> _onFetchFriendPosts(FetchFriendPosts event, Emitter<FriendPostState> emit) async {
    emit(FriendPostLoading());
    try {
      final response = await http.post(
        Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/feed/feed/${event.friendId}'),
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
