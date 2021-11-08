import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String message;
  final String username;
  final bool isMe;
  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.username,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: isMe
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
            color: isMe
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
          ),
          width: 180.0,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 16.0,
                  ),
                ),
              Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
