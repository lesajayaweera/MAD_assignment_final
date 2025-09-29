class User {
  final int id;
  final String name;
  final String profilePhotoUrl;

  User({
    required this.id,
    required this.name,
    required this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePhotoUrl: json['profile_photo_url'] as String,
    );
  }
}