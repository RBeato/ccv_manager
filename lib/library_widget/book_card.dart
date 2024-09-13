import 'package:ccv_manager/models/library_models/book_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/check_is_mobile.dart';
import '../common/custom_text_for_card.dart';
import '../events_widget/common/row_column_mobile_conditional_builder.dart';

class BookCard extends StatelessWidget {
  const BookCard({required this.item, this.constraints, super.key});
  final BookRequest item;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    bool isDelivered = item.deliveryDate != null;

    return Card(
        color: isDelivered ? Colors.grey[200] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: isDelivered ? Colors.grey : Colors.teal, width: 1.0),
        ),
        elevation: isDelivered ? 1 : 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConditionalParentWidget(
                  condition: isMobile(constraints),
                  children: [
                    CustomTextForCard("Nome do requerente: ", item.userName),
                    CustomTextForCard("ID do requerente: ", item.userId),
                    CustomTextForCard(
                        "Nº de livros : ", item.books.length.toString()),
                  ]),
              const Divider(),
              ...item.books
                  .map((book) => ConditionalParentWidget(
                        condition: isMobile(constraints),
                        children: [
                          CustomTextForCard("Título: ", book.title),
                          CustomTextForCard("Autor: ", book.author),
                          CustomTextForCard("Edição: ", book.edition),
                        ],
                      ))
                  .toList(),
              const Divider(),
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  CustomTextForCard("Data de requisição: ",
                      DateFormat('yyyy-MM-dd HH:mm').format(item.requestDate)),
                  CustomTextForCard("Data limite para entrega: ",
                      DateFormat('yyyy-MM-dd HH:mm').format(item.requestDate)),
                ],
              ),
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  isDelivered
                      ? CustomTextForCard(
                          "Data de entrega: ",
                          item.deliveryDate == null
                              ? ""
                              : DateFormat('yyyy-MM-dd HH:mm')
                                  .format(item.deliveryDate!))
                      : Container(),
                  CustomTextForCard("Renovou requisição: ",
                      item.renewed == true ? "Sim" : "Não"),
                ],
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextForCard(
                      "Observações: ", item.observations ?? "")),
            ],
          ),
        ));
  }
}
