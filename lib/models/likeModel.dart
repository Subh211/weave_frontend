class Like {
  final String userId;
  final String userName;
  final String userProfileImage;
  final bool isLiked;

  Like({required this.userId, required this.userName, required this.userProfileImage, required this.isLiked});

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Unknown User',
      userProfileImage: json['userProfileImage'] ?? 'path/to/default/image.png',
      isLiked: json['isLiked'] ?? false,
    );
  }
}
