class usersPost {
  final bool? isLiked;
  final String? postId;
  final String? usersId;
  final String? name;
  final String? profileImage;
  final String? profileId;
  final String? postImage;
  final String? postImageId;
  final int likes;
  final String? caption;
  final List<String> comments;

  usersPost({
    this.isLiked,
    this.postId,
    this.usersId,
    this.name,
    this.profileImage,
    this.profileId,
    this.postImage,
    this.postImageId,
    this.likes = 0,
    this.caption,
    this.comments = const [],
  });

  factory usersPost.fromJson(Map<String, dynamic> json) {
    return usersPost(
      isLiked: json['isLiked'] as bool?,
      usersId: json['usersId'] as String?,
      postId: json['postId'] as String?,
      name: json['name'] as String?,
      profileImage: json['image_secure_url'] as String?,
      postImage: json['picture_secure_url'] as String?,
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
        'isLiked: $isLiked, '
        'usersId: $usersId, '
        'postId: $postId, '
        'name: $name, '
        'profileImage: $profileImage, '
        'postImage: $postImage, '
        'likes: $likes, '
        'caption: $caption, '
        'comments: $comments}';
  }
}





