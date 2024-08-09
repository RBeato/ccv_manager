import 'package:ccv_manager/shift_off_day_widget/shift_off_day_view/shift_off_day_view_page.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../common/check_is_mobile.dart';
import '../../common/custom_text_for_card.dart';
import '../../constants/constants.dart';
import '../../events_widget/common/row_column_mobile_conditional_builder.dart';

class PersonalAppointmentCard extends StatelessWidget {
  const PersonalAppointmentCard({this.item, this.constraints, super.key});
  final item;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ShiftOffDayViewingPage(item)));
      },
      child: Card(
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
                        "Funcionário: ",
                        item.assignedEmployee.name ??
                            "Não há funcionários registados"),
                    item.eventType == EventType.offDay
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: item.backgroundColor,
                                    width: 0.3,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Ausência ",
                                    style: TextStyle(
                                      color: item.backgroundColor,
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : CustomTextForCard(
                            "Tipo de turno: ",
                            item.type ?? "Não definido",
                            style: TextStyle(
                              color: item.backgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ]),
              ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  CustomTextForCard("Data de início: ",
                      DateTimeUtils.toDateTimeString(item.fromDate)),
                  CustomTextForCard("Data de fim: ",
                      DateTimeUtils.toDateTimeString(item.toDate)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
