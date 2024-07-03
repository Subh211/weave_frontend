import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentInProgress extends CommentState {}

class CommentSuccess extends CommentState {}

class CommentFailure extends CommentState {
  final String error;

  const CommentFailure({required this.error});

  @override
  List<Object> get props => [error];
}
