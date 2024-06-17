// like_state.dart
import 'package:equatable/equatable.dart';
import 'package:weave_frontend/models/commentModel.dart';
abstract class CommentScreenState extends Equatable {
  const CommentScreenState();

  @override
  List<Object?> get props => [];
}

class CommentScreenInitial extends CommentScreenState {}

class CommentScreenLoading extends CommentScreenState {}

class CommentScreenLoaded extends CommentScreenState {
  final List<Comment> comments;

  const CommentScreenLoaded(this.comments);

  @override
  List<Object?> get props => [comments];
}

class CommentScreenError extends CommentScreenState {
  final String message;

  const CommentScreenError(this.message);

  @override
  List<Object?> get props => [message];
}
