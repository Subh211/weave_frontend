import 'package:weave_frontend/models/postModel.dart';
import 'package:weave_frontend/models/usersFeedModel.dart';

abstract class UserPostState {}

class UserPostInitial extends UserPostState {}

class UserPostLoading extends UserPostState {}

class UserPostLoaded extends UserPostState {
  final List<usersPost> posts;

  UserPostLoaded(this.posts);
}

class UserPostError extends UserPostState {
  final String message;

  UserPostError(this.message);
}

class UserPostAuthenticationError extends UserPostState {
  final String message;

  UserPostAuthenticationError(this.message);
}
