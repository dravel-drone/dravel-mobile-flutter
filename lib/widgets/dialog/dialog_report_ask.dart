import 'package:flutter/material.dart';

Future<bool?> showAskDialog({
  required BuildContext context,
  required String message,
  String? allowText,
  String? cancelText,
  String? title,
}) {

  Widget dialog = AskDialog(
    title: title,
    message: message,
    allowText: allowText,
    cancelText: cancelText,
  );

  return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}

class AskDialog extends StatelessWidget {
  AskDialog({
    this.title,
    this.allowText,
    this.cancelText,
    required this.message,
  });
  String? title;
  String message;

  String? allowText;
  String? cancelText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title == null ? "삭제 확인" : title!),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(cancelText ?? "취소", style: TextStyle(color: Colors.black87),),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        TextButton(
          child: Text(allowText ?? "삭제", style: TextStyle(color: Colors.red),),
          onPressed: () {
            Navigator.pop(context, true);
          },
        )
      ],
      actionsPadding: EdgeInsets.fromLTRB(12, 0, 12, 8),
      contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 8),
    );
  }
}