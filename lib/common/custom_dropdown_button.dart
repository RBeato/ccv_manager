import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {this.selectedValue,
      required this.onPressed,
      required this.items,
      super.key});

  final String? selectedValue;
  final void Function(String?)? onPressed;
  final List<String> items;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.selectedValue == "" ? null : widget.selectedValue,
        onChanged: widget.onPressed,
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
