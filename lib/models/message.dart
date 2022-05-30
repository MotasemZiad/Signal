import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final Timestamp createdAt;
  final String userId;
  final String username;
  final String userImage;

  Message({
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userImage,
    required this.username,
  });
}
