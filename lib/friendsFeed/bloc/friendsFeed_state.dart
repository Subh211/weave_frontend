import 'package:weave_frontend/models/friendsFeedModel.dart';

abstract class FriendPostState {}

class FriendPostInitial extends FriendPostState {}

class FriendPostLoading extends FriendPostState {}

class FriendPostLoaded extends FriendPostState {
  final List<FriendsPost> posts;

  FriendPostLoaded(this.posts);
}

class FriendPostError extends FriendPostState {
  final String message;

  FriendPostError(this.message);
}

class FriendPostAuthenticationError extends FriendPostState {
  final String message;

  FriendPostAuthenticationError(this.message);
}
