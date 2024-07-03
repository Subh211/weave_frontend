import 'package:equatable/equatable.dart';
import 'package:weave_frontend/models/profileModel.dart';

abstract class GetFriendProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class FriendProfileInitial extends GetFriendProfileState {}

class FriendProfileLoading extends GetFriendProfileState {}

class FriendProfileLoaded extends GetFriendProfileState {
  final Profile profile;

  FriendProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class FriendProfileError extends GetFriendProfileState {
  final String error;

  FriendProfileError(this.error);

  @override
  List<Object> get props => [error];
}





