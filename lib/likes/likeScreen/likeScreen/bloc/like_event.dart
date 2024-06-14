import 'package:equatable/equatable.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object?> get props => [];
}

class FetchLikes extends LikeEvent {
  final String postId;
  final String friendId;

  const FetchLikes(this.postId, this.friendId);

  @override
  List<Object?> get props => [postId, friendId];
}
