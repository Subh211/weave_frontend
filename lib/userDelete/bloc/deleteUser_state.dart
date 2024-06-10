import 'package:equatable/equatable.dart';

abstract class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

class DeleteUserInitial extends DeleteUserState {}

class DeleteUserLoading extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {
  final String message;

  const DeleteUserSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteUserFailure extends DeleteUserState {
  final String error;

  const DeleteUserFailure(errorMessage, {required this.error});

  @override
  List<Object> get props => [error];
}

