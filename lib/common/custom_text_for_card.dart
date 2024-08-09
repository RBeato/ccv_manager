import 'package:flutter/material.dart';

class CustomTextForCard extends StatelessWidget {
  const CustomTextForCard(
    this.title,
    this.text, {
    this.style,
    super.key,
  });
  final String title;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: text,
            style: style ??
                const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
