import 'package:flutter/material.dart';

class DataStatsWidget extends StatelessWidget {
  const DataStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Dados Estatísticos",
      style: TextStyle(color: Colors.grey),
    ));
  }
}
