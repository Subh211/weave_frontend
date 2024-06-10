import 'package:equatable/equatable.dart';

abstract class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object> get props => [];
}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSuccess extends SignOutState {
  final String message;

  const SignOutSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SignOutFailure extends SignOutState {
  final String error;

  const SignOutFailure(errorMessage, {required this.error});

  @override
  List<Object> get props => [error];
}

