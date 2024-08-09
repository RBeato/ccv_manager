import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../common/check_is_mobile.dart';
import '../common/custom_text_for_card.dart';
import '../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../models/visitors/visitor_register_event.dart';

class VisitorDataCard extends StatelessWidget {
  const VisitorDataCard({required this.item, this.constraints, super.key});
  final VisitorRegisterEvent item;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.teal, width: 1.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  CustomTextForCard(
                      "Entrada: ", DateTimeUtils.toDateString(item.fromDate)),
                  CustomTextForCard(
                      "Contagem: ", item.visitorCounter.toString()),
                ],
              ),
              CustomTextForCard(
                  "Observações: ", item.observations ?? "Nada registado"),
            ],
          ),
        ));
  }
}
