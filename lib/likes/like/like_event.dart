import 'package:equatable/equatable.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object?> get props => [];
}

class LikePost extends LikeEvent {
  final String friendId;
  final String postId;

  const LikePost({required this.friendId, required this.postId});

  @override
  List<Object?> get props => [friendId, postId];
}

class UnlikePost extends LikeEvent {
  final String friendId;
  final String postId;

  const UnlikePost({required this.friendId, required this.postId});

  @override
  List<Object?> get props => [friendId, postId];
}
