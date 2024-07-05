abstract class FriendPostEvent {}

class FetchFriendPosts extends FriendPostEvent {
  final String friendId;

  FetchFriendPosts({required this.friendId});

  @override
  List<Object?> get props => [friendId];
}
