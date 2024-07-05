class allUserModel {
  final String displayName;
  final String id;
  final String photoURL;

  allUserModel({
    required this.displayName,
    required this.id,
    required this.photoURL,
  });

  factory allUserModel.fromJson(Map<String, dynamic> json) {
    return allUserModel(
      displayName: json['displayName'] ?? 'Unknown',
      id: json['id'] ?? '',
      photoURL: json['photoURL'] ?? 'assets/images/placeholder.png',
    );
  }
}
