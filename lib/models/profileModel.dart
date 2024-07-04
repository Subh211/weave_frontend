// class Profile {
//   final User user;
//   final UserPosts posts;
//   final FriendDetails friendDetails;
//   final bool isFriend;
//
//   Profile({
//     required this.user,
//     required this.posts,
//     required this.friendDetails,
//     required this.isFriend,
//   });
//
//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       user: User.fromJson(json['user']),
//       posts: UserPosts.fromJson(json['posts']),
//       friendDetails: json['friendDetails'] != null
//           ? FriendDetails.fromJson(json['friendDetails'])
//           : FriendDetails.empty(), // Use empty FriendDetails if null
//       isFriend: json['isFriend'] ?? false, // Handle null isFriend
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
//       photoURL: json['photoURL'] != null ? json['photoURL']['secure_url'] : '',
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
//     List<dynamic> postsList = json['posts'] ?? [];
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
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['_id'],
//       postOwnerId: json['postOwnerId'],
//       postOwnerDisplayName: json['postOwnerDisplayName'],
//       caption: json['caption'],
//       image: json['image'] != null ? json['image']['secure_url'] : '',
//     );
//   }
// }
//
// class FriendDetails {
//   final String id;
//   final String userId;
//   final List<Following> following;
//   final List<Following> followers; // Updated type to List<Following>
//   final String createdAt;
//   final String updatedAt;
//   final int version;
//
//   FriendDetails({
//     required this.id,
//     required this.userId,
//     required this.following,
//     required this.followers,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//   });
//
//   factory FriendDetails.fromJson(Map<String, dynamic> json) {
//     List<dynamic> followingList = json['following'] ?? [];
//     List<Following> parsedFollowing = followingList.map((followJson) => Following.fromJson(followJson)).toList();
//
//     List<dynamic> followersList = json['followers'] ?? [];
//     List<Following> parsedFollowers = followersList.map((followerJson) => Following.fromJson(followerJson)).toList();
//
//     return FriendDetails(
//       id: json['_id'],
//       userId: json['userId'],
//       following: parsedFollowing,
//       followers: parsedFollowers,
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       version: json['__v'] ?? 0,
//     );
//   }
//
//   // Factory method for empty FriendDetails
//   factory FriendDetails.empty() {
//     return FriendDetails(
//       id: '0',
//       userId: '0',
//       following: [],
//       followers: [],
//       createdAt: '0',
//       updatedAt: '0',
//       version: 0,
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
//   factory Following.fromJson(Map<String, dynamic> json) {
//     return Following(
//       id: json['_id'],
//       friendId: json['friendId'],
//       friendName: json['friendName'],
//       friendImage: json['friendImage'] != null ? json['friendImage']['secure_url'] : '',
//       date: json['date'],
//     );
//   }
// }













class Profile {
  final User user;
  final UserPosts posts;
  final FriendDetails friendDetails;
  final bool isFriend;

  Profile({
    required this.user,
    required this.posts,
    required this.friendDetails,
    required this.isFriend,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: User.fromJson(json['user']) ,
      // posts: UserPosts.fromJson(json['posts']),
      posts: json['posts'] != null
        ? UserPosts.fromJson(json['posts'])
          : UserPosts.empty()
      ,
      friendDetails: json['friendDetails'] != null
          ? FriendDetails.fromJson(json['friendDetails'])
          : FriendDetails.empty(), // Use empty FriendDetails if null
      isFriend: json['isFriend'] ?? false, // Handle null isFriend
    );
  }
}

class User {
  final String id;
  final String displayName;
  final String name;
  final String? email;
  final String role;
  final String bio;
  final String createdAt;
  final String updatedAt;
  final String photoURL;

  User({
    required this.id,
    required this.displayName,
    required this.name,
    this.email,
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
      email: json['email'],
      role: json['role'],
      bio: json['bio'] != null ? json['bio'] : '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      photoURL: json['photoURL'] != null ? json['photoURL']['secure_url'] : '',
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

  factory UserPosts.empty () {
    return UserPosts(
        id: '0',
        userId: '0',
        posts: [],
        createdAt: '0',
        updatedAt: '0'
    );
  }
}

class Post {
  final String id;
  final String postOwnerId;
  final String postOwnerDisplayName;
  final String caption;
  final String image;

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
      image: json['image'] != null ? json['image']['secure_url'] : '',
    );
  }
}

class FriendDetails {
  final String id;
  final String userId;
  final List<Following> following;
  final List<Following> followers; // Updated type to List<Following>
  final String createdAt;
  final String updatedAt;
  final int version;

  FriendDetails({
    required this.id,
    required this.userId,
    required this.following,
    required this.followers,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory FriendDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> followingList = json['following'] ?? [];
    List<Following> parsedFollowing = followingList.map((followJson) => Following.fromJson(followJson)).toList();

    List<dynamic> followersList = json['followers'] ?? [];
    List<Following> parsedFollowers = followersList.map((followerJson) => Following.fromJson(followerJson)).toList();

    return FriendDetails(
      id: json['_id'],
      userId: json['userId'],
      following: parsedFollowing,
      followers: parsedFollowers,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'] ?? 0,
    );
  }

  // Factory method for empty FriendDetails
  factory FriendDetails.empty() {
    return FriendDetails(
      id: '0',
      userId: '0',
      following: [],
      followers: [],
      createdAt: '0',
      updatedAt: '0',
      version: 0,
    );
  }
}

class Following {
  final String id;
  final String friendId;
  final String friendName;
  final String friendImage;
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
      friendImage: json['friendImage'] != null ? json['friendImage']['secure_url'] : '',
      date: json['date'],
    );
  }
}
