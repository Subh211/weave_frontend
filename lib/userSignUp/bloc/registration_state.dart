import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final String message;

  const RegistrationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure(this.error,  {required String error1});

  @override
  List<Object> get props => [error];
}
