import 'package:flutter/material.dart';

showDialogBox(
        {context,
        title,
        content,
        confirmText,
        cancelText,
        OnPressedConfirm,
        onPressedCancel}) =>
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            cancelText != null
                ? TextButton(
                    child: Text(cancelText),
                    onPressed: () async => onPressedCancel())
                : Container(),
            confirmText != null
                ? TextButton(
                    child: Text(confirmText),
                    onPressed: () async {
                      await OnPressedConfirm();
                    },
                  )
                : Container(),
          ],
        );
      },
    );
