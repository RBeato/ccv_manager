import 'package:ccv_manager/constants/constants.dart';
import 'package:flutter/material.dart';

import '../common/check_is_mobile.dart';
import '../common/custom_text_for_card.dart';
import '../utils/date_time_utils.dart';
import 'common/row_column_mobile_conditional_builder.dart';

class EventCard extends StatelessWidget {
  const EventCard({this.item, this.constraints, super.key});
  final BoxConstraints? constraints;
  final item;

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ConditionalParentWidget(condition: isMobile(constraints), children: [
            CustomTextForCard("Descrição: ", item.title),
            CustomTextForCard(
              "Tipo de evento: ",
              Constants.eventTypeToString[item.eventType] ?? "",
              style: TextStyle(
                  color: item.backgroundColor, fontWeight: FontWeight.bold),
            ),
          ]),
          ConditionalParentWidget(
            condition: isMobile(constraints),
            children: [
              CustomTextForCard("Data de início: ",
                  DateTimeUtils.toDateTimeString(item.fromDate)),
              CustomTextForCard(
                  "Data de fim: ", DateTimeUtils.toDateTimeString(item.toDate)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: CustomTextForCard("Descrição: ", item.title ?? "")),
            ],
          ),
          ConditionalParentWidget(
            condition: isMobile(constraints),
            children: [
              CustomTextForCard(
                  "Número de pessoas: ", item.numberOfPeople?.toString() ?? ""),
              CustomTextForCard(
                  "Equipamento: ", item.equipment.toString() ?? ""),
            ],
          ),
          ConditionalParentWidget(
            condition: isMobile(constraints),
            children: [
              CustomTextForCard("Entidade Requerente: ", item.requester ?? ""),
              CustomTextForCard("Sala: ", item.room.toString() ?? ""),
            ],
          ),
          ConditionalParentWidget(
            condition: isMobile(constraints),
            children: [
              CustomTextForCard(
                  "Criador do evento: ", item.eventCreator ?? "Não registado"),
              CustomTextForCard(
                  "Data de criação do evento: ",
                  item.eventCreationDate != null
                      ? DateTimeUtils.toDateTimeString(item.eventCreationDate)
                      : "Não registado"),
            ],
          ),
          ConditionalParentWidget(
            condition: isMobile(constraints),
            children: [
              CustomTextForCard("Último editor do evento: ",
                  item.lastEditedBy ?? "Não registado"),
              CustomTextForCard(
                  "Data da última edição: ",
                  item.lastEditedOn != null
                      ? DateTimeUtils.toDateTimeString(item.lastEditedOn)
                      : "Não registado"),
            ],
          ),
          ConditionalParentWidget(condition: isMobile(constraints), children: [
            CustomTextForCard("Funcionários envolvidos: ",
                item.employees.map((e) => e.name).toList().join(', ') ?? ""),
            CustomTextForCard("Funcionário Responsável: ",
                item.assignedEmployee?.name ?? "Não designado"),
          ]),
          Align(
              alignment: Alignment.centerLeft,
              child:
                  CustomTextForCard("Observações: ", item.observations ?? "")),
        ]),
      ),
    );
  }
}
