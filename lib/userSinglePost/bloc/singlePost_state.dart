import 'package:weave_frontend/models/postModel.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final String username; // Add this line

  PostLoaded(this.posts,this.username);
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}

class PostAuthenticationError extends PostState {
  final String message;

  PostAuthenticationError(this.message);
}
