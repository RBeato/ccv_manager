import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/custom_elevated_button.dart';
import '../home_page/provider/tile_selection_provider.dart';
import 'data_export_page.dart';

class ExportWidget extends ConsumerStatefulWidget {
  const ExportWidget({super.key});

  @override
  ConsumerState<ExportWidget> createState() => _ExportButtonState();
}

class _ExportButtonState extends ConsumerState<ExportWidget> {
  @override
  Widget build(BuildContext context) {
    final page = ref.read(pageSelectionProvider);

    return Row(
      children: [
        const Text("Dados: "),
        CustomElevatedButton(
            text: "Exportar",
            icon: Icons.file_download,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DataExportPage()));
            }),
      ],
    );
  }
}
