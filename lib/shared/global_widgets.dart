import 'package:flutter/material.dart';
import 'package:signal_chat/utils/constants.dart';

class GlobalWidgets {
  GlobalWidgets._();
  static final globalWidgets = GlobalWidgets._();

  presentSnackBar({
    required BuildContext context,
    required String content,
    int duration = 1500,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
        duration: Duration(milliseconds: duration),
      ),
    );
  }

  presentDialog({
    required BuildContext context,
    required String content,
    String? title,
    String? actionTitle1,
    String? actionTitle2,
    Function()? actionFunction1,
    Function()? actionFunction2,
    Color? titleColor,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title ?? '',
          style: TextStyle(
            color: titleColor ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: actionFunction1,
            child: Text(
              actionTitle1 ?? '',
              style: const TextStyle(
                color: primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: actionFunction2,
            child: Text(
              actionTitle2 ?? '',
              style: const TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
