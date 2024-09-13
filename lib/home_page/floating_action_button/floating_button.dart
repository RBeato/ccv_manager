import 'package:ccv_manager/home_page/provider/tile_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import 'get_label.dart';
import 'next_page_filter.dart';

class CustomFloatingButton extends ConsumerStatefulWidget {
  const CustomFloatingButton({super.key, this.title, this.onPressed});

  final Function? onPressed;
  final String? title;

  @override
  _CustomFloatingButtonState createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends ConsumerState<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(pageSelectionProvider);
    if (selectedPage == PageSelection.notifications ||
        selectedPage == PageSelection.settings) return Container();
    return FloatingActionButton.extended(
      label: widget.title != null
          ? Text(widget.title!)
          : Text(getLabel(selectedPage)),
      backgroundColor: Colors.teal,
      onPressed: () async {
        if (widget.onPressed != null) {
          await widget.onPressed!();
        } else {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NextPageFilter(selectedPage)));
        }
      },
      icon: const Icon(Icons.add, color: Colors.white),
    );
  }
}
