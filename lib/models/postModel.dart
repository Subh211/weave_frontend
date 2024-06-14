class Post {
  final String? friendId;
  final String? postId;
  final String? username;
  final String? profileImage;
  final String? postImage;
  final int likes;
  final String? caption;
  final List<String> comments;

  Post({
    this.friendId,
    this.postId,
    this.username,
    this.profileImage,
    this.postImage,
    this.likes = 0,
    this.caption,
    this.comments = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      friendId: json['friendId'] as String,
      postId: json['postId'] as String,
      username: json['name'] as String?,
      profileImage: json['image_secure_url'] as String?,
      postImage: json['picture_secure_url'] as String?,
      likes: (json['likes'] as List<dynamic>?)?.length ?? 0,
      caption: json['caption'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
    );
  }
}
