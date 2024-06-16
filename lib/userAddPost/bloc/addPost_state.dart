import 'package:equatable/equatable.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {
  final String message;

  const AddPostSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddPostFailure extends AddPostState {
  final String error;

  const AddPostFailure(this.error);

  @override
  List<Object> get props => [error];
}
