import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late final String text;
  late final Timestamp createdAt;
  late final String userId;
  late final String username;
  late final String userImage;

  Message({
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userImage,
    required this.username,
  });

  Message.toJson(Map<String, dynamic> json) {
    text = json['text'];
    createdAt = json['createdAt'];
    userId = json['userId'];
    username = json['username'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'createdAt': createdAt,
      'userId': userId,
      'username': username,
      'userImage': userImage,
    };
  }
}
