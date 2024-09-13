import 'package:ccv_manager/events_widget/event_editing_page.dart';
import 'package:ccv_manager/events_widget/event_view/provider/auditorium_data_provider.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../common/check_is_mobile.dart';
import '../../constants/constants.dart';
import '../../models/cultural_events/cultural_event.dart';
import '../common/row_column_mobile_conditional_builder.dart';
import '../provider/event_provider.dart';
import 'auditiorium_button.dart';
import 'package:url_launcher/url_launcher.dart';

class EventViewPage extends ConsumerStatefulWidget {
  const EventViewPage(this.event, {this.details, super.key});

  final CulturalEvent? event;
  final CalendarTapDetails? details;

  @override
  ConsumerState<EventViewPage> createState() => _EventViewingPageState();
}

class _EventViewingPageState extends ConsumerState<EventViewPage> {
  List<CulturalEvent> events = [];

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      events.add(widget.event!);
    } else {
      late Iterable<CulturalEvent> e;
      if (widget.details!.date != null) {
        e = ref.read(eventsProvider).where((e) {
          print("e.from: ${e.fromDate}");
          print("widget.details!.date!: ${widget.details!.date!}");
          return e.fromDate == widget.details!.date!;
        });
      }
      events.addAll(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(auditoriumDataProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Evento"),
          leading: const CloseButton(),
          backgroundColor: Colors.teal,
          actions: [
            ElevatedButton.icon(
              label: const Text("Editar"),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EventEditingPage(event: widget.event))),
              icon: const Icon(Icons.edit),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(children: events.map((e) => event(e)).toList())),
        ));
  }

  // if(constraints.max)

  Widget event(CulturalEvent event) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConditionalParentWidget(
                condition: isMobile(constraints),
                children: [
                  rowText("Descrição: ", event.title ?? "sem nome"),
                  event.room == Constants.mainAuditorium
                      ? AuditoriumButton(event)
                      : Container()
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                ConditionalParentWidget(
                  condition: isMobile(constraints),
                  children: [
                    rowText("Início: ",
                        DateTimeUtils.toDateTimeString(event.fromDate)),
                    rowText(
                        "Fim: ", DateTimeUtils.toDateTimeString(event.toDate)),
                    rowText(
                        "Dia todo: ", event.isAllDay == true ? "Sim" : "Não"),
                  ],
                ),
                ConditionalParentWidget(
                  condition: isMobile(constraints),
                  children: [
                    rowText(
                        "Tipo de evento: ",
                        Constants.eventTypeToString[event.eventType] ??
                            "Não assinalado"),
                    rowText(
                        "Entidade requerente: ",
                        event.requester == null
                            ? "Não registado"
                            : event.requester.toString()),
                    rowText("Preço: ", event.price.toString() ?? "Gratuíto"),
                  ],
                )
              ]),
            ),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ConditionalParentWidget(
                  condition: isMobile(constraints),
                  children: [
                    rowText("Sala: ", event.room ?? "sem spaceRoom"),
                    rowText("Número de pessoas: ",
                        event.numberOfPeople.toString() ?? "Não registado"),
                  ],
                ),
                rowText("Equipamento necessário: ",
                    event.equipment ?? "Equipamento não descriminado."),
                ConditionalParentWidget(
                    condition: isMobile(constraints),
                    children: [
                      Row(
                        children: [
                          const Text("Funcionários envolvidos: ",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black38)),
                          ...event.employees!
                              .map((e) => Text("${e.name}, ",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black87)))
                              .toList()
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: rowText("Funcionário responsável: ",
                                event.assignedEmployee?.name ?? ""),
                          ),
                        ],
                      ),
                    ]),
                ConditionalParentWidget(
                  condition: isMobile(constraints),
                  children: [
                    rowText("Criador do registo: ",
                        event.eventCreator ?? "sem eventCreator"),
                    rowText(
                      "Evento criado a: ",
                      DateTimeUtils.toDateTimeString(
                          event.eventCreationDate ?? DateTime.now()),
                    ),
                  ],
                ),
                ConditionalParentWidget(
                  condition: isMobile(constraints),
                  children: [
                    rowText(
                        "Última edição feita por: ", event.lastEditedBy ?? ""),
                    rowText(
                        "Data da última edição: ",
                        DateTimeUtils.toDateTimeString(
                            event.lastEditedOn ?? DateTime.now())),
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
                event.observations == null
                    ? ""
                    : event.observations.toString()),
          )),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: rowText(
                "Avaliação: ", event.evaluation ?? "Ainda não foi avaliado"),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _launchURL,
              child: const Text('Ver anexos'),
            ),
          ),
        ],
      );
    });
  }

  void _launchURL() async {
    var url = "https://www.dropbox.com/";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Cannot load Url $url";
    }
  }

  Row rowText(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(key ?? "sem key",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, color: Colors.black38)),
        Text(value ?? "sem value",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, color: Colors.black87)),
      ],
    );
  }
}
