import 'package:flutter/material.dart';

class CategorySelectionButton extends StatefulWidget {
  const CategorySelectionButton(
      {required this.title,
      required this.onPressed,
      required this.selection,
      super.key});
  final String title;
  final Function onPressed;
  final String selection;

  @override
  State<CategorySelectionButton> createState() =>
      _CategorySelectionButtonState();
}

class _CategorySelectionButtonState extends State<CategorySelectionButton> {
  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final selection = widget.selection;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (title == 'Senior' && selection == 'Senior') {
              return Colors.purple;
            }
            if (title == 'Junior' && selection == 'Junior') {
              return Colors.lightBlue[200]!;
            }
            if (title == 'Regular' && selection == 'Regular') {
              return Colors.teal;
            }
            return Colors.grey;
          },
        ),
      ),
      onPressed: () {
        widget.onPressed();
        setState(() {});
      },
      child: Text(title),
    );
  }
}
