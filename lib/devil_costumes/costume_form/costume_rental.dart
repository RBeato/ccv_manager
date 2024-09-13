import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../common/check_is_mobile.dart';
import '../../common/form_fields/basic_text_form.dart';
import '../../common/form_fields/date_time_field.dart';
import '../../events_widget/common/row_column_mobile_conditional_builder.dart';
import 'buy_costume.dart';

class CostumeRental extends StatelessWidget {
  CostumeRental({
    super.key,
    required this.reqType,
    this.constraints,
  });

  final String reqType;
  late String? observations;
  late DateTime requestDate;
  late DateTime deliveryDate;
  late DateTime deadlineDate;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ConditionalParentWidget(
                  condition: isMobile(constraints),
                  children: [
                    DateTimePicker(
                      header: "Data de Requisição",
                      needsHour: false,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (newDateTime) {
                        final formattedDate =
                            DateTimeUtils.toDateString(newDateTime);
                        final formattedTime =
                            DateTimeUtils.toTimeString(newDateTime);
                        print('Selected date: $formattedDate');
                        print('Selected time: $formattedTime');
                        requestDate = newDateTime;
                      },
                    ),
                    const SizedBox(width: 16),
                    DateTimePicker(
                      header: "Data de Entrega",
                      needsHour: false,
                      initialDateTime:
                          DateTime.now().add(const Duration(days: 15)),
                      onDateTimeChanged: (newDateTime) {
                        final formattedDate =
                            DateTimeUtils.toDateString(newDateTime);
                        final formattedTime =
                            DateTimeUtils.toTimeString(newDateTime);
                        print('Selected date: $formattedDate');
                        print('Selected time: $formattedTime');
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: DateTimePicker(
                      header: "Data Limite para Entrega",
                      needsHour: false,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (newDateTime) {
                        final formattedDate =
                            DateTimeUtils.toDateString(newDateTime);
                        final formattedTime =
                            DateTimeUtils.toTimeString(newDateTime);
                        print('Selected date: $formattedDate');
                        print('Selected time: $formattedTime');
                        deadlineDate = newDateTime;
                      },
                    )),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 3,
          shadowColor: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BuyCostume(reqType: reqType),
                  BasicTextForm(
                    title: 'Observações',
                    isRequired: false,
                    onChanged: (value) {
                      observations = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
