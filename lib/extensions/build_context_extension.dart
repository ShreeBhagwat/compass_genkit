import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void navigateToScreen(Widget screen, {bool isReplace = false}) {
    if (isReplace) {
      Navigator.of(this).pushReplacement(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    } else {
      Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    }
  }

  void showDialogScreen(String dialogTitle, String? dialogBody) {
    showDialog(
      context: this,
      builder: (_) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Text(dialogBody ?? ''),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(this).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
