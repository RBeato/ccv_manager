import 'package:ccv_manager/shift_off_day_widget/provider/offday_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/shift_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/delete_button.dart';
import '../../constants/constants.dart';
import '../../models/personal_work_register/personal_work_register.dart';
import '../../utils/date_time_utils.dart';

class ShiftOffDayViewingPage extends ConsumerStatefulWidget {
  const ShiftOffDayViewingPage(this.event, {super.key});
  final PersonalWorkRegisterEvent event;

  @override
  ConsumerState<ShiftOffDayViewingPage> createState() =>
      _ShiftOffDayViewingPageState();
}

class _ShiftOffDayViewingPageState
    extends ConsumerState<ShiftOffDayViewingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getEventDescription() ?? "Não tem descrição"),
          leading: const CloseButton(),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          rowText(
                              "Funcionário: ",
                              widget.event.assignedEmployee?.name ??
                                  "Não atribuído"),
                          rowText(
                              "Tipo: ", widget.event.type ?? "Não atribuído"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Column(
                          children: [
                            rowText(
                                "Início: ",
                                DateTimeUtils.toDateTimeString(
                                    widget.event.fromDate)),
                            rowText(
                                "Fim: ",
                                DateTimeUtils.toDateTimeString(
                                    widget.event.toDate)),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: rowText(
                                "Registo feito a : ",
                                DateTimeUtils.toDateTimeString(
                                    widget.event.eventCreationDate ??
                                        DateTime.now()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: rowText(
                        "Observações: ",
                        widget.event.observations == null
                            ? ""
                            : widget.event.observations.toString()),
                  )),
                ],
              ),
              CardViewDeleteButton(
                buttonText: "Eliminar",
                dialogTitleText: "Eliminar Evento",
                contentText: "Tem a certeza que pretende eliminar este evento?",
                actionButtonText: "ELIMINAR",
                onPressed: () async {
                  deleteEvent().then((_) => Navigator.of(context).pop());
                },
              )
            ],
          ),
        ));
  }

  Future<void> deleteEvent() async {
    if (widget.event.eventType == EventType.shift) {
      ref.read(shiftProvider.notifier).remove(widget.event);
    }
    if (widget.event.eventType == EventType.offDay) {
      ref.read(offDayProvider.notifier).remove(widget.event);
    }
  }

  getEventDescription() {
    if (widget.event.eventType == EventType.shift) {
      return "Turno";
    }
    if (widget.event.eventType == EventType.offDay) {
      return "Folga";
    }
  }

  Row rowText(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(key ?? "sem key",
            style: const TextStyle(fontSize: 18, color: Colors.black38)),
        Text(value ?? "sem value",
            style: const TextStyle(fontSize: 18, color: Colors.black87)),
      ],
    );
  }
}
