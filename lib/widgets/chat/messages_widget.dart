import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signal_chat/utils/constants.dart';
import 'package:signal_chat/widgets/chat/message_bubble_widget.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: marginVertical,
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return MessageBubbleWidget(
                message: chatDocs[index]['text'],
                username: chatDocs[index]['username'],
                isMe: chatDocs[index]['userId'] == user!.uid,
                key: ValueKey(chatDocs[index].id),
              );
            },
            itemCount: chatDocs.length,
            reverse: true,
          ),
        );
      },
    );
  }
}
