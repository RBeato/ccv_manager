import 'package:flutter/material.dart';

import '../../common/custom_dropdown_with_title.dart';

class TypeSelection extends StatefulWidget {
  const TypeSelection(
      {required this.title,
      required this.items,
      required this.onPressed,
      required this.selectedValue,
      super.key});

  final String title;
  final List<String> items;
  final Function onPressed;
  final String selectedValue;

  @override
  State<TypeSelection> createState() => _TypeSelectionState();
}

class _TypeSelectionState extends State<TypeSelection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: DropdownMenuWithTitle(
            items: widget.items, //  Constants.shiftTypes,
            title: widget.title,
            addTitle: true,
            onPressed: (value) => widget.onPressed(value!),
            selectedValue: widget.selectedValue, //    _selectedSwitchValue,
          ),
        ),
      ),
    );
  }
}
