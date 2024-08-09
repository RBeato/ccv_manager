import 'package:ccv_manager/settings_widget/export_widget.dart';
import 'package:ccv_manager/settings_widget/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mode_widget.dart';

class SettingsWidget extends ConsumerStatefulWidget {
  const SettingsWidget({super.key});

  @override
  ConsumerState<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              children: const [
                ModeWidget(),
                LogoutWidget(),
                ExportWidget(),
              ],
            ),
          ])),
    );
  }
}
