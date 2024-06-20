// // class Profile {
// //   final bool success;
// //   final String message;
// //   final ProfileData data;
// //
// //   Profile({
// //     required this.success,
// //     required this.message,
// //     required this.data,
// //   });
// //
// //   factory Profile.fromJson(Map<String, dynamic> json) {
// //     return Profile(
// //       success: json['success'],
// //       message: json['message'],
// //       data: ProfileData.fromJson(json['data']),
// //     );
// //   }
// // }
// //
// // class ProfileData {
// //   final User user;
// //   final Posts posts;
// //
// //   ProfileData({
// //     required this.user,
// //     required this.posts,
// //   });
// //
// //   factory ProfileData.fromJson(Map<String, dynamic> json) {
// //     return ProfileData(
// //       user: User.fromJson(json['user']),
// //       posts: Posts.fromJson(json['posts']),
// //     );
// //   }
// // }
// //
// // class User {
// //   final PhotoURL photoURL;
// //   final String id;
// //   final String displayName;
// //   final String name;
// //   final String email;
// //   final String role;
// //   final String bio;
// //   final String createdAt;
// //   final String updatedAt;
// //   final bool v;
// //
// //   User({
// //     required this.photoURL,
// //     required this.id,
// //     required this.displayName,
// //     required this.name,
// //     required this.email,
// //     required this.role,
// //     required this.bio,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.v,
// //   });
// //
// //   factory User.fromJson(Map<String, dynamic> json) {
// //     return User(
// //       photoURL: PhotoURL.fromJson(json['photoURL']),
// //       id: json['_id'],
// //       displayName: json['displayName'],
// //       name: json['name'],
// //       email: json['email'],
// //       role: json['role'],
// //       bio: json['bio'],
// //       createdAt: json['createdAt'],
// //       updatedAt: json['updatedAt'],
// //       v: json['__v'],
// //     );
// //   }
// // }
// //
// // class PhotoURL {
// //   final String publicId;
// //   final String secureUrl;
// //
// //   PhotoURL({
// //     required this.publicId,
// //     required this.secureUrl,
// //   });
// //
// //   factory PhotoURL.fromJson(Map<String, dynamic> json) {
// //     return PhotoURL(
// //       publicId: json['public_id'],
// //       secureUrl: json['secure_url'],
// //     );
// //   }
// // }
// //
// // class Posts {
// //   final String id;
// //   final String userId;
// //   final List<Post> posts;
// //   final String createdAt;
// //   final String updatedAt;
// //   final int v;
// //
// //   Posts({
// //     required this.id,
// //     required this.userId,
// //     required this.posts,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.v,
// //   });
// //
// //   factory Posts.fromJson(Map<String, dynamic> json) {
// //     return Posts(
// //       id: json['_id'],
// //       userId: json['userId'],
// //       posts: List<Post>.from(json['posts'].map((post) => Post.fromJson(post))),
// //       createdAt: json['createdAt'],
// //       updatedAt: json['updatedAt'],
// //       v: json['__v'],
// //     );
// //   }
// // }
// //
// // class Post {
// //   final PhotoURL postOwnerProfilePicture;
// //   final PhotoURL image;
// //   final String postOwnerDisplayName;
// //   final String postOwnerId;
// //   final String caption;
// //   final String id;
// //   final List<dynamic> comments;
// //   final List<dynamic> likes;
// //
// //   Post({
// //     required this.postOwnerProfilePicture,
// //     required this.image,
// //     required this.postOwnerDisplayName,
// //     required this.postOwnerId,
// //     required this.caption,
// //     required this.id,
// //     required this.comments,
// //     required this.likes,
// //   });
// //
// //   factory Post.fromJson(Map<String, dynamic> json) {
// //     return Post(
// //       postOwnerProfilePicture: PhotoURL.fromJson(json['postOwnerProfilePicture']),
// //       image: PhotoURL.fromJson(json['image']),
// //       postOwnerDisplayName: json['postOwnerDisplayName'],
// //       postOwnerId: json['postOwnerId'],
// //       caption: json['caption'],
// //       id: json['_id'],
// //       comments: List<dynamic>.from(json['comments']),
// //       likes: List<dynamic>.from(json['likes']),
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
//
//
//
//
//
//
//
//
//
//
//
// class Profile {
//   final User user;
//   final UserPosts posts;
//   final FriendDetails friendDetails;
//
//   Profile({
//     required this.user,
//     required this.posts,
//     required this.friendDetails,
//   });
//
//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       user: User.fromJson(json['user']),
//       posts: UserPosts.fromJson(json['posts']),
//       friendDetails: FriendDetails.fromJson(json['friendDetails']),
//     );
//   }
// }
//
// class User {
//   final String id;
//   final String displayName;
//   final String name;
//   final String email;
//   final String role;
//   final String bio;
//   final String createdAt;
//   final String updatedAt;
//   final String photoURL; // Assuming you want the secure_url from photoURL
//
//   User({
//     required this.id,
//     required this.displayName,
//     required this.name,
//     required this.email,
//     required this.role,
//     required this.bio,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.photoURL,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       displayName: json['displayName'],
//       name: json['name'],
//       email: json['email'],
//       role: json['role'],
//       bio: json['bio'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       photoURL: json['photoURL']['secure_url'],
//     );
//   }
// }
//
// class UserPosts {
//   final String id;
//   final String userId;
//   final List<Post> posts;
//   final String createdAt;
//   final String updatedAt;
//
//   UserPosts({
//     required this.id,
//     required this.userId,
//     required this.posts,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory UserPosts.fromJson(Map<String, dynamic> json) {
//     List<dynamic> postsList = json['posts'];
//     List<Post> parsedUserPosts = postsList.map((postJson) => Post.fromJson(postJson)).toList();
//
//     return UserPosts(
//       id: json['_id'],
//       userId: json['userId'],
//       posts: parsedUserPosts,
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }
// }
//
// class Post {
//   final String id;
//   final String postOwnerId;
//   final String postOwnerDisplayName;
//   final String caption;
//   final String image; // Assuming you want the secure_url from image
//
//   Post({
//     required this.id,
//     required this.postOwnerId,
//     required this.postOwnerDisplayName,
//     required this.caption,
//     required this.image,
//   });
//
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['_id'],
//       postOwnerId: json['postOwnerId'],
//       postOwnerDisplayName: json['postOwnerDisplayName'],
//       caption: json['caption'],
//       image: json['image']['secure_url'],
//     );
//   }
// }
//
// class FriendDetails {
//   final String id;
//   final String userId;
//   final List<Following> following;
//   final List<dynamic> followers;
//   final String createdAt;
//   final String updatedAt;
//
//   FriendDetails({
//     required this.id,
//     required this.userId,
//     required this.following,
//     required this.followers,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory FriendDetails.fromJson(Map<String, dynamic> json) {
//     List<dynamic> followingList = json['following'];
//     List<Following> parsedFollowing = followingList.map((followJson) => Following.fromJson(followJson)).toList();
//
//     return FriendDetails(
//       id: json['_id'],
//       userId: json['userId'],
//       following: parsedFollowing,
//       followers: json['followers'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }
// }
//
// class Following {
//   final String id;
//   final String friendId;
//   final String friendName;
//   final String friendImage; // Assuming you want the secure_url from friendImage
//   final int date;
//
//   Following({
//     required this.id,
//     required this.friendId,
//     required this.friendName,
//     required this.friendImage,
//     required this.date,
//   });
//
//   factory Following.fromJson(Map<String, dynamic> json) {
//     return Following(
//       id: json['_id'],
//       friendId: json['friendId'],
//       friendName: json['friendName'],
//       friendImage: json['friendImage']['secure_url'],
//       date: json['date'],
//     );
//   }
// }











class Profile {
  final User user;
  final UserPosts posts;
  final FriendDetails friendDetails;

  Profile({
    required this.user,
    required this.posts,
    required this.friendDetails,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: User.fromJson(json['user']),
      posts: UserPosts.fromJson(json['posts']),
      friendDetails: FriendDetails.fromJson(json['friendDetails']),
    );
  }
}

class User {
  final String id;
  final String displayName;
  final String name;
  final String? email; // Nullable fields should be marked with '?'
  final String role;
  final String bio;
  final String createdAt;
  final String updatedAt;
  final String photoURL; // Assuming you want the secure_url from photoURL

  User({
    required this.id,
    required this.displayName,
    required this.name,
    this.email, // Nullable field
    required this.role,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
    required this.photoURL,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      displayName: json['displayName'],
      name: json['name'],
      email: json['email'], // Can be null in JSON
      role: json['role'],
      bio: json['bio'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      photoURL: json['photoURL'] != null ? json['photoURL']['secure_url'] : '', // Handle potential null
    );
  }
}

class UserPosts {
  final String id;
  final String userId;
  final List<Post> posts;
  final String createdAt;
  final String updatedAt;

  UserPosts({
    required this.id,
    required this.userId,
    required this.posts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPosts.fromJson(Map<String, dynamic> json) {
    List<dynamic> postsList = json['posts'] ?? [];
    List<Post> parsedUserPosts = postsList.map((postJson) => Post.fromJson(postJson)).toList();

    return UserPosts(
      id: json['_id'],
      userId: json['userId'],
      posts: parsedUserPosts,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Post {
  final String id;
  final String postOwnerId;
  final String postOwnerDisplayName;
  final String caption;
  final String image; // Assuming you want the secure_url from image

  Post({
    required this.id,
    required this.postOwnerId,
    required this.postOwnerDisplayName,
    required this.caption,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      postOwnerId: json['postOwnerId'],
      postOwnerDisplayName: json['postOwnerDisplayName'],
      caption: json['caption'],
      image: json['image'] != null ? json['image']['secure_url'] : '', // Handle potential null
    );
  }
}

class FriendDetails {
  final String id;
  final String userId;
  final List<Following> following;
  final List<dynamic>? followers; // Nullable field
  final String createdAt;
  final String updatedAt;

  FriendDetails({
    required this.id,
    required this.userId,
    required this.following,
    this.followers, // Nullable field
    required this.createdAt,
    required this.updatedAt,
  });

  factory FriendDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> followingList = json['following'] ?? [];
    List<Following> parsedFollowing = followingList.map((followJson) => Following.fromJson(followJson)).toList();

    return FriendDetails(
      id: json['_id'],
      userId: json['userId'],
      following: parsedFollowing,
      followers: json['followers'], // Can be null in JSON
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Following {
  final String id;
  final String friendId;
  final String friendName;
  final String friendImage; // Assuming you want the secure_url from friendImage
  final int date;

  Following({
    required this.id,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    required this.date,
  });

  factory Following.fromJson(Map<String, dynamic> json) {
    return Following(
      id: json['_id'],
      friendId: json['friendId'],
      friendName: json['friendName'],
      friendImage: json['friendImage'] != null ? json['friendImage']['secure_url'] : '', // Handle potential null
      date: json['date'],
    );
  }
}







//
//
// class Profile {
//   final User? user;
//   final UserPosts? posts;
//   final FriendDetails? friendDetails;
//
//   Profile({
//     required this.user,
//     required this.posts,
//     required this.friendDetails,
//   });
//
//   factory Profile.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return Profile(user: null, posts: null, friendDetails: null);
//     return Profile(
//       user: json['user'] != null ? User.fromJson(json['user']) : null,
//       posts: json['posts'] != null ? UserPosts.fromJson(json['posts']) : null,
//       friendDetails: json['friendDetails'] != null ? FriendDetails.fromJson(json['friendDetails']) : null,
//     );
//   }
// }
//
// class User {
//   final String id;
//   final String displayName;
//   final String name;
//   final String? email;
//   final String role;
//   final String bio;
//   final String createdAt;
//   final String updatedAt;
//   final String photoURL;
//
//   User({
//     required this.id,
//     required this.displayName,
//     required this.name,
//     this.email,
//     required this.role,
//     required this.bio,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.photoURL,
//   });
//
//   factory User.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return User(id: '', displayName: '', name: '', role: '', bio: '', createdAt: '', updatedAt: '', photoURL: '');
//     return User(
//       id: json['_id'] ?? '',
//       displayName: json['displayName'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'],
//       role: json['role'] ?? '',
//       bio: json['bio'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       photoURL: json['photoURL'] != null ? json['photoURL']['secure_url'] ?? '' : '',
//     );
//   }
// }
//
// class UserPosts {
//   final String id;
//   final String userId;
//   final List<Post> posts;
//   final String createdAt;
//   final String updatedAt;
//
//   UserPosts({
//     required this.id,
//     required this.userId,
//     required this.posts,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory UserPosts.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return UserPosts(id: '', userId: '', posts: [], createdAt: '', updatedAt: '');
//     List<dynamic> postsList = json['posts'] ?? [];
//     List<Post> parsedUserPosts = postsList.map((postJson) => Post.fromJson(postJson)).toList();
//
//     return UserPosts(
//       id: json['_id'] ?? '',
//       userId: json['userId'] ?? '',
//       posts: parsedUserPosts,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }
// }
//
// class Post {
//   final String id;
//   final String postOwnerId;
//   final String postOwnerDisplayName;
//   final String caption;
//   final String image;
//
//   Post({
//     required this.id,
//     required this.postOwnerId,
//     required this.postOwnerDisplayName,
//     required this.caption,
//     required this.image,
//   });
//
//   factory Post.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return Post(id: '', postOwnerId: '', postOwnerDisplayName: '', caption: '', image: '');
//     return Post(
//       id: json['_id'] ?? '',
//       postOwnerId: json['postOwnerId'] ?? '',
//       postOwnerDisplayName: json['postOwnerDisplayName'] ?? '',
//       caption: json['caption'] ?? '',
//       image: json['image'] != null ? json['image']['secure_url'] ?? '' : '',
//     );
//   }
// }
//
// class FriendDetails {
//   final String id;
//   final String userId;
//   final List<Following> following;
//   final List<dynamic>? followers;
//   final String createdAt;
//   final String updatedAt;
//
//   FriendDetails({
//     required this.id,
//     required this.userId,
//     required this.following,
//     this.followers,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory FriendDetails.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return FriendDetails(id: '', userId: '', following: [], createdAt: '', updatedAt: '');
//     List<dynamic> followingList = json['following'] ?? [];
//     List<Following> parsedFollowing = followingList.map((followJson) => Following.fromJson(followJson)).toList();
//
//     return FriendDetails(
//       id: json['_id'] ?? '',
//       userId: json['userId'] ?? '',
//       following: parsedFollowing,
//       followers: json['followers'],
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }
// }
//
// class Following {
//   final String id;
//   final String friendId;
//   final String friendName;
//   final String friendImage;
//   final int date;
//
//   Following({
//     required this.id,
//     required this.friendId,
//     required this.friendName,
//     required this.friendImage,
//     required this.date,
//   });
//
//   factory Following.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return Following(id: '', friendId: '', friendName: '', friendImage: '', date: 0);
//     return Following(
//       id: json['_id'] ?? '',
//       friendId: json['friendId'] ?? '',
//       friendName: json['friendName'] ?? '',
//       friendImage: json['friendImage'] != null ? json['friendImage']['secure_url'] ?? '' : '',
//       date: json['date'] ?? 0,
//     );
//   }
// }
