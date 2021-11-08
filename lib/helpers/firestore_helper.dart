import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static final firestoreHelper = FirestoreHelper._();

  static const usersCollection = 'users';
  static const chatCollection = 'chat';

  final firebaseFirestore = FirebaseFirestore.instance;
}
