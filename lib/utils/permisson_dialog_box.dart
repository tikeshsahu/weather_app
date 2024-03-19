import 'package:flutter/material.dart';

Future<bool> showPermissionDialogBox(context) async {
  bool status = false;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Location Permission Required to use this app"),
        actions: [
          TextButton(
            onPressed: () {
              status = false;
              Navigator.pop(context);
              return;
            },
            child: const Text(
              "Don't Allow",
            ),
          ),
          TextButton(
            onPressed: () {
              status = true;
              Navigator.pop(context);

              return;
            },
            child: const Text(
              "Allow",
            ),
          ),
        ],
      );
    },
  );

  return status;
}
