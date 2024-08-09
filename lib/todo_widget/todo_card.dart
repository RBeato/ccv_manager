import 'package:flutter/material.dart';

import '../common/check_is_mobile.dart';
import '../common/custom_text_for_card.dart';
import '../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../utils/date_time_utils.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({required this.item, this.constraints, super.key});
  final item;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    bool isCompleted = item.isCompleted != null;

    return Card(
        color: isCompleted ? Colors.grey[200] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: isCompleted ? Colors.grey : Colors.teal, width: 1.0),
        ),
        elevation: isCompleted ? 1 : 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForCard("Título: ", item.title),
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  CustomTextForCard(
                    "De: ",
                    DateTimeUtils.toDateTimeString(item.fromDate),
                  ),
                  CustomTextForCard(
                      "Até: ", DateTimeUtils.toDateTimeString(item.toDate)),
                ],
              ),
              // ConditionalParentWidget(
              //     condition: isMobile(constraints),
              //     children: [
              //       // CustomTextForCard("Requerente: ", item.requester),
              //       CustomTextForCard("Funcionário responsável: ",
              //           item.assignedEmployee.name ?? ""),
              //     ]),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextForCard(
                      "Observações: ", item.observations ?? "")),
            ],
          ),
        ));
  }
}
