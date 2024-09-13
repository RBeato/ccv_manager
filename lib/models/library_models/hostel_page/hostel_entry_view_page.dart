import 'package:ccv_manager/models/hostel_register/hostel_register.dart';
import 'package:ccv_manager/models/library_models/hostel_page/hostel_entry_form.dart';
import 'package:ccv_manager/models/library_models/hostel_page/providers/hostel_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/delete_button.dart';
import '../../../utils/date_time_utils.dart';

class HostelEntryViewPage extends ConsumerStatefulWidget {
  const HostelEntryViewPage(this.event, {super.key});
  final HostelRegisterEvent event;

  @override
  ConsumerState<HostelEntryViewPage> createState() =>
      _HostelEntryViewPageState();
}

class _HostelEntryViewPageState extends ConsumerState<HostelEntryViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Entrada no Albergue"),
          leading: const CloseButton(),
          backgroundColor: Colors.teal,
          actions: [
            ElevatedButton.icon(
              label: const Text("Editar"),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HostelEntryForm(event: widget.event))),
              icon: const Icon(Icons.edit),
            )
          ],
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
                              "Nome: ", widget.event.title ?? "Não atribuído"),
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
                                "Hora de entrada: ",
                                DateTimeUtils.toDateTimeString(
                                    widget.event.fromDate)),
                            // rowText("Hora de saída: ", Utils.toDateTime(widget.event.to)),
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
                contentText:
                    "Tem a certeza que pretende eliminar este registo?",
                actionButtonText: "ELIMINAR",
                onPressed: () async {
                  ref
                      .read(hostelProvider.notifier)
                      .remove(widget.event)
                      .then((_) => closePopUP());
                },
              )
            ],
          ),
        ));
  }

  void closePopUP() {
    Navigator.of(context).pop(); // pop dialog
    Navigator.of(context).pop(); // pop page
    Navigator.of(context).pop(); // pop bottom sheet
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
