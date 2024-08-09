import 'package:ccv_manager/models/notifications/change_notification.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../common/custom_text_for_card.dart';
import '../constants/constants.dart';
import '../models/library_models/book_request.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(this.item, {super.key});
  final InfoNotification item;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: item.status == RequisitionStatus.delivered
                  ? Colors.grey
                  : Colors.teal,
              width: 1.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: CustomTextForCard("Título: ", item.title)),
                  Expanded(
                      flex: 1,
                      child: CustomTextForCard(
                          "data: ", DateTimeUtils.toDateTimeString(item.date))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item.employees != null
                      ? Expanded(
                          flex: 1,
                          child: CustomTextForCard(
                              "Funcionário(s): ",
                              item.employees
                                      ?.map((e) => e.name)
                                      .toList()
                                      .join(", ") ??
                                  "Não atribuído"))
                      : Container(),
                  Expanded(
                      flex: 1,
                      child: CustomTextForCard(
                          "Assunto: ",
                          item.eventType == null
                              ? ""
                              : Constants
                                  .eventCategoryToString[item.eventType]!)),
                ],
              ),
              CustomTextForCard("Descrição: ", item.description ?? ""),
            ],
          ),
        ));
  }
}
