class allUserModel {
  final String username;
  final String displayName;
  final String id;
  final String photoURL;

  allUserModel({
    required this.username,
    required this.displayName,
    required this.id,
    required this.photoURL,
  });

  factory allUserModel.fromJson(Map<String, dynamic> json) {
    return allUserModel(
      username: json['username'] ?? 'unknown',
      displayName: json['displayName'] ?? 'Unknown',
      id: json['id'] ?? '',
      photoURL: json['photoURL'] ?? 'assets/images/placeholder.png',
    );
  }
}
