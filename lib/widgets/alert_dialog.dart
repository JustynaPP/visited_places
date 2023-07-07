import 'package:flutter/material.dart';

class TextButtonAlertDialog extends StatefulWidget {
  const TextButtonAlertDialog({Key? key, required this.dialogText})
      : super(key: key);

  final String dialogText;

  @override
  State<TextButtonAlertDialog> createState() => _TextButtonAlertDialogState();
}

class _TextButtonAlertDialogState extends State<TextButtonAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.dialogText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
