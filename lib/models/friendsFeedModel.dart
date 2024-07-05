class FriendsPost {
  final String? postId;
  final String? friendsId;
  final String? name;
  final String? profileImage;
  final String? profileImageId;
  final String? postImage;
  final String? postImageId;
  final int likes;
  final String? caption;
  final List<String> comments;

  FriendsPost({
    this.postId,
    this.friendsId,
    this.name,
    this.profileImage,
    this.profileImageId,
    this.postImage,
    this.postImageId,
    this.likes = 0,
    this.caption,
    this.comments = const [],
  });

  factory FriendsPost.fromJson(Map<String, dynamic> json) {
    return FriendsPost(
      postId: json['postId'] as String?,
      friendsId: json['friendsId'] as String?,
      name: json['name'] as String?,
      profileImage: json['image_secure_url'] as String?,
      profileImageId: json['image_public_id'] as String?,
      postImage: json['picture_secure_url'] as String?,
      postImageId: json['picture_public_id'] as String?,
      likes: (json['likes'] as List<dynamic>?)?.length ?? 0,
      caption: json['caption'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
    );
  }

  @override
  String toString() {
    return '{'
        'postId: $postId, '
        'friendsId: $friendsId, '
        'name: $name, '
        'profileImage: $profileImage, '
        'profileImageId: $profileImageId, '
        'postImage: $postImage, '
        'postImageId: $postImageId, '
        'likes: $likes, '
        'caption: $caption, '
        'comments: $comments}';
  }
}
