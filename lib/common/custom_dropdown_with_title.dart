import 'package:ccv_manager/common/check_is_mobile.dart';
import 'package:ccv_manager/common/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownMenuWithTitle extends ConsumerStatefulWidget {
  const DropdownMenuWithTitle({
    Key? key,
    required this.title,
    required this.items,
    this.selectedValue,
    required this.onPressed,
    this.addTitle = false,
  }) : super(key: key);

  final String title;
  final List<String> items;
  final String? selectedValue;
  final void Function(String?)? onPressed;
  final bool? addTitle;

  @override
  _DropdownMenuWithTitleState createState() => _DropdownMenuWithTitleState();
}

class _DropdownMenuWithTitleState extends ConsumerState<DropdownMenuWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          widget.addTitle == true
              ? Text(
                  "${widget.title}: ",
                  style: TextStyle(
                      fontSize: isMobile() ? 15 : 18, color: Colors.black54),
                )
              : Container(),
          // const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: CustomDropDownButton(
              selectedValue: widget.selectedValue,
              items: widget.items,
              onPressed: widget.onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
