import 'package:flutter/material.dart';

class AppErrorDialog {
 static void get(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Message'),
        content: const Text('Your file is saved.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
