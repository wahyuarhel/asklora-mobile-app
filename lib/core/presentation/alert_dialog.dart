import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String message,
    {Function? onPressedOk, String title = 'Error'}) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  if (onPressedOk != null) {
                    onPressedOk();
                  }
                },
                child: const Text('Okay'),
              ),
            ],
          ));
}
