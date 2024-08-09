import 'package:flutter/material.dart';

class ConditionalParentWidget extends StatelessWidget {
  const ConditionalParentWidget({
    Key? key,
    required this.condition,
    required this.children,
  }) : super(key: key);

  final bool condition;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return condition
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children)
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: children.map((e) => Expanded(child: e)).toList(),
          );
  }
}
