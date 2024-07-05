import 'package:equatable/equatable.dart';
import 'package:weave_frontend/models/allUser.dart';

abstract class AlluserState extends Equatable{
  const AlluserState();

  @override
  List<Object?> get props => [];
}

class AlluserStateInitial extends AlluserState{}

class AlluserStateLoading extends AlluserState{}

class AlluserStateLoaded extends AlluserState{
  List<allUserModel> users;

  AlluserStateLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class AlluserStateError extends AlluserState{
  final String message;

  AlluserStateError({required this.message});

  @override
  List<Object?> get props => [message];
}