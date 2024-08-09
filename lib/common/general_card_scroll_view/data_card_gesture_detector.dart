import 'package:flutter/material.dart';

class DataCardGestureDetector extends StatelessWidget {
  const DataCardGestureDetector({this.viewPage, required this.card, super.key});
  final Widget? viewPage;
  final Widget card;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (viewPage != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => viewPage!));
        }
      },
      child: card,
    );
  }
}
