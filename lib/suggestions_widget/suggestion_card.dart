import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../common/custom_text_for_card.dart';

class SuggestionCard extends StatelessWidget {
  const SuggestionCard(this.item, {super.key});
  final item;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2, child: CustomTextForCard("Autor: ", item.author)),
              Expanded(
                flex: 1,
                child: CustomTextForCard(
                    "Data: ", DateFormat('yyyy-MM-dd HH:mm').format(item.date)),
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: CustomTextForCard("Descrição: ", item.description)),
        ],
      ),
    ));
  }
}
