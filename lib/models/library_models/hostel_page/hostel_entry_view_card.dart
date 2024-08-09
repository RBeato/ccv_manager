import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../common/check_is_mobile.dart';
import '../../../common/custom_text_for_card.dart';
import '../../../events_widget/common/row_column_mobile_conditional_builder.dart';

class HostelEntryViewCard extends StatelessWidget {
  const HostelEntryViewCard({required this.item, this.constraints, super.key});
  final CalendarEvent item;
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
                  CustomTextForCard("Nome: ", item.title!),
                  CustomTextForCard("Entrada: ",
                      DateTimeUtils.toDateTimeString(item.fromDate)),
                ],
              ),
              CustomTextForCard(
                  "Observações: ", item.observations ?? "Nada registado"),
            ],
          ),
        ));
  }
}
