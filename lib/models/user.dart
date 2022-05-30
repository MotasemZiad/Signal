class User {
  late final String username;
  late final String email;
  late final String imageUrl;

  User({
    required this.username,
    required this.email,
    required this.imageUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
