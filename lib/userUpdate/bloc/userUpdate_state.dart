import 'package:equatable/equatable.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final String message;

  const UpdateUserSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateUserFailure extends UpdateUserState {
  final String error;

  const UpdateUserFailure(this.error);

  @override
  List<Object> get props => [error];
}
