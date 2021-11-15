import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:signal_chat/shared/global_widgets.dart';
import 'package:signal_chat/utils/constants.dart';
import 'package:signal_chat/widgets/chat/messages_widget.dart';
import 'package:signal_chat/widgets/chat/new_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        elevation: 2.0,
        actions: [
          IconButton(
            onPressed: () {
              GlobalWidgets.globalWidgets.presentDialog(
                context: context,
                content: 'Are you sure you want to logout from the app?',
                title: 'Logout',
                actionFunction1: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                actionFunction2: () {
                  Navigator.of(context).pop();
                },
                actionTitle1: 'Yup',
                actionTitle2: 'Nope',
                titleColor: Colors.red,
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: const MessagesWidget(),
              onTap: () {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          const NewMessageWidget(),
        ],
      ),
    );
  }
}
