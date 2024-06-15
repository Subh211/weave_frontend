import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class DoCommentEvent extends CommentEvent {
  final String postId;
  final String friendId;
  final String comment;

  const DoCommentEvent({required this.postId, required this.friendId,required this.comment});

  @override
  List<Object> get props => [postId, friendId,comment];
}


