import 'package:equatable/equatable.dart';

abstract class CommentScreenEvent extends Equatable {
  const CommentScreenEvent();

  @override
  List<Object?> get props => [];
}

class FetchComments extends CommentScreenEvent {
  final String postId;
  final String friendId;

  const FetchComments(this.postId, this.friendId);

  @override
  List<Object?> get props => [postId, friendId];
}
