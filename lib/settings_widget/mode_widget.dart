import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/custom_elevated_button.dart';
import '../constants/constants.dart';
import 'provider/theme_provider.dart';

class ModeWidget extends ConsumerStatefulWidget {
  const ModeWidget({super.key});

  @override
  ConsumerState<ModeWidget> createState() => _ModeWidgetState();
}

class _ModeWidgetState extends ConsumerState<ModeWidget> {
  IconData _icon = Icons.brightness_2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Modo: "),
        CustomElevatedButton(
            text: "Modo",
            icon: _icon,
            onPressed: () {
              setState(() {
                if (_icon == Icons.wb_sunny) {
                  _icon = Icons.brightness_2;
                  ref
                      .read(themeProvider.notifier)
                      .update((state) => ThemeType.dark);
                } else {
                  _icon = Icons.wb_sunny;
                  ref
                      .read(themeProvider.notifier)
                      .update((state) => ThemeType.light);
                }
              });
            }),
      ],
    );
  }
}
