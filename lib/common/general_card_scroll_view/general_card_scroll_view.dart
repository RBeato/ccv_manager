import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home_page/provider/filters_provider.dart';
import 'general_card.dart';

class GeneralCardListWidget extends ConsumerWidget {
  const GeneralCardListWidget(this.data, {super.key});
  final List data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(filtersProvider);
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: data.isEmpty
            ? const Center(child: Text("Não há informação para mostrar"))
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GeneralCard(
                      item: data[index], constraints: constraints);
                },
              ),
      ),
    );
  }
}
