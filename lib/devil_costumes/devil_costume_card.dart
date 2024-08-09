import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/check_is_mobile.dart';
import '../common/custom_text_for_card.dart';
import '../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../models/library_models/book_request.dart';
import '../models/devil_costumes/devil_costume_request.dart';

class DevilCostumeCard extends StatelessWidget {
  const DevilCostumeCard({required this.item, this.constraints, super.key});
  final DevilCostumeRequest item;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: item.status == RequisitionStatus.delivered
            ? Colors.grey[200]
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: item.status == RequisitionStatus.delivered
                ? Colors.grey
                : Colors.teal,
            width: 1.0,
          ),
        ),
        // color: Colors.teal[50],
        elevation: item.status == RequisitionStatus.delivered ? 1 : 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  CustomTextForCard("Nome: ", item.name),
                  CustomTextForCard("Morada: ", item.address),
                ],
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomTextForCard(
                      "Contacto: ", item.phoneNumber.toString())),
              const Divider(),
              ...getCostumesDetails(item),
              const Divider(),
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  CustomTextForCard(
                      "Data de requisição: ",
                      item.requestDate == null
                          ? ""
                          : DateFormat('yyyy-MM-dd HH:mm')
                              .format(item.requestDate!)),
                  CustomTextForCard(
                      "Data limite para entrega: ",
                      item.requestDate == null
                          ? ""
                          : DateFormat('yyyy-MM-dd HH:mm')
                              .format(item.requestDate!)),
                ],
              ),
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  CustomTextForCard(
                    "Entregou: ",
                    item.status == RequisitionStatus.delivered ? "sim" : "não",
                  ),
                  CustomTextForCard(
                      "Data de entrega: ",
                      item.deliveryDate == null
                          ? ""
                          : DateFormat('yyyy-MM-dd HH:mm')
                              .format(item.deliveryDate!)),
                ],
              ),
            ],
          ),
        ));
  }

  getCostumesDetails(DevilCostumeRequest item) {
    var temp = <Widget>[];
    for (var costumeSize in item.costumes) {
      temp.add(Row(children: [
        Expanded(
            child: CustomTextForCard(
                "Número de fatos: ", costumeSize.quantity.toString())),
        Expanded(child: CustomTextForCard("Tamanho: ", costumeSize.size)),
      ]));
    }
    return temp;
  }
}
