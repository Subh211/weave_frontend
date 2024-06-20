

import 'package:equatable/equatable.dart';

//abstract class GetFriendProfileEvent  {}
abstract class GetFriendProfileEvent extends Equatable {
  const GetFriendProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchFriendProfileEvent extends GetFriendProfileEvent {
  final String friendId;

  const FetchFriendProfileEvent({required this.friendId});

  @override
  List<Object> get props => [friendId];
}