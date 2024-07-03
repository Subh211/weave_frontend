import 'package:equatable/equatable.dart';
import 'package:weave_frontend/models/profileModel.dart';

abstract class GetUserProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends GetUserProfileState {}

class UserProfileLoading extends GetUserProfileState {}

class UserProfileLoaded extends GetUserProfileState {
  final Profile profile;

  UserProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class UserProfileError extends GetUserProfileState {
  final String error;

  UserProfileError(this.error);

  @override
  List<Object> get props => [error];
}





