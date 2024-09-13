import 'package:flutter/material.dart';

class CardViewDeleteButton extends StatelessWidget {
  const CardViewDeleteButton(
      {required this.buttonText,
      required this.dialogTitleText,
      required this.contentText,
      required this.actionButtonText,
      required this.onPressed,
      super.key});

  final String buttonText;
  final String dialogTitleText;
  final String contentText;
  final String actionButtonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, shadowColor: Colors.red),
        icon: const Icon(Icons.delete),
        label: Text(buttonText),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(dialogTitleText),
                  content: Text(contentText),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("CANCELAR"),
                    ),
                    TextButton(
                      onPressed: () => onPressed(),
                      child: Text(actionButtonText),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
