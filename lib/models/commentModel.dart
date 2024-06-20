class Comment {
  final String userId;
  final String userName;
  final String userImage;
  final String comment;

  Comment({required this.userId, required this.userName, required this.userImage, required this.comment});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Unknown User',
      userImage: json['userImage'] ?? 'assests/images/placeholder.png',
      comment: json['comment'] ?? " ",
    );
  }
}
