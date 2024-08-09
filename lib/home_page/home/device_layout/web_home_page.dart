import 'package:flutter/material.dart';

import '../../drawer/custom_drawer.dart';
import '../../top_bar_functionality/top_bar_functionality.dart';
import '../data_widget_selector.dart';

class WebVersion extends StatelessWidget {
  const WebVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            constraints: const BoxConstraints(minWidth: 300),
            child: const CustomDrawer(
              isMobile: false,
            )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FunctionalityBar(),
              ),
              SizedBox(height: 20),
              Expanded(
                // Added Expanded here
                child: Center(child: HomeDataWidgetSelector()),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
