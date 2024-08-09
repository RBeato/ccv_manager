import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/events_widget/event_additional_form_page.dart';
import 'package:ccv_manager/events_widget/event_logic.dart';
import 'package:ccv_manager/home_page/home/home_page.dart';
import 'package:ccv_manager/models/cultural_events/cultural_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/check_is_mobile.dart';
import '../common/custom_dropdown_with_title.dart';
import '../common/delete_button.dart';
import '../common/form_fields/basic_text_form.dart';
import '../common/form_fields/date_time_field.dart';
import '../common/show_dialog_box.dart';
import '../models/employee.dart';
import 'common/employee_checkbox_list.dart';
import 'common/row_column_mobile_conditional_builder.dart';

class EventEditingPage extends ConsumerStatefulWidget {
  const EventEditingPage({Key? key, this.event}) : super(key: key);

  final CulturalEvent? event;

  @override
  EventEditingPageState createState() => EventEditingPageState();
}

class EventEditingPageState extends ConsumerState<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  String? _eventValue;
  late CulturalEvent event;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      event = CulturalEvent(
          fromDate: DateTime.now(),
          toDate: DateTime.now().add(const Duration(hours: 1)));
    } else {
      event = widget.event!;

      _eventValue = widget.event!.eventType != null
          ? Constants.eventTypeToString.entries
              .firstWhere((element) => element.key == widget.event!.eventType)
              .value
          : null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventLogic = ref.watch(culturalEventEditingProvider);
    double space = 30;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Editar Evento"),
          leading: const CloseButton(),
          actions: buildEditingActions(() => eventLogic
              .saveForm(widget.event!, event, mounted)
              .then((_) => goHome())),
          backgroundColor: Colors.teal,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BasicTextForm(
                        title: "Descrição",
                        initialValue: event.title ?? '',
                        isRequired: true,
                        onChanged: (value) {
                          event.title = value;
                        },
                      ),
                    )),
                    Card(
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            ConditionalParentWidget(
                              condition: isMobile(constraints),
                              children: [
                                DateTimePicker(
                                  header: 'Início:',
                                  needsHour: true,
                                  initialDateTime: event.fromDate,
                                  onDateTimeChanged: (newDateTime) {
                                    event.fromDate = newDateTime;
                                  },
                                ),
                                DateTimePicker(
                                  header: 'Fim:',
                                  needsHour: true,
                                  initialDateTime: event.toDate,
                                  onDateTimeChanged: (newDateTime) {
                                    event.toDate = newDateTime;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: space),
                            ConditionalParentWidget(
                              condition: isMobile(constraints),
                              children: [
                                DropdownMenuWithTitle(
                                  title: "Tipo de evento",
                                  items: Constants.eventTypeToString.values
                                      .toList(),
                                  onPressed: (value) {
                                    event.eventType = Constants
                                        .eventTypeToString.entries
                                        .firstWhere(
                                            (element) => element.value == value)
                                        .key;
                                    setState(() {
                                      _eventValue = value;
                                    });
                                  },
                                  selectedValue: _eventValue,
                                  addTitle: true,
                                ),
                                event.eventType != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EventAdditionalFormPage(
                                                        event: event,
                                                        constraints:
                                                            constraints,
                                                        availableEmployees:
                                                            event.employees ??
                                                                [],
                                                        onFormTasksChanged:
                                                            (newFormTasks) {
                                                          event.formTasks =
                                                              newFormTasks;
                                                        }),
                                              ));
                                            },
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                        "Tarefas associadas ao evento",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                DropdownMenuWithTitle(
                                  title: "Espaço",
                                  items: Constants.roomsList,
                                  onPressed: (value) {
                                    setState(() {
                                      event.room = value;
                                    });
                                  },
                                  addTitle: true,
                                  selectedValue: event.room,
                                ),
                              ],
                            )
                          ])),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ConditionalParentWidget(
                                condition: isMobile(constraints),
                                children: [
                                  BasicTextForm(
                                    title: "Entidade requerente",
                                    isRequired: false,
                                    initialValue: event.requester,
                                    onChanged: (value) {
                                      setState(() {
                                        event.requester = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: space),
                                  BasicTextForm(
                                      title: "Número de partipantes",
                                      isRequired: false,
                                      isNumber: true,
                                      initialValue:
                                          event.numberOfPeople?.toString() ??
                                              "",
                                      onChanged: (value) {
                                        setState(() {
                                          if (value != null) {
                                            event.numberOfPeople =
                                                int.tryParse(value);
                                          }
                                        });
                                      }),
                                  SizedBox(height: space),
                                  BasicTextForm(
                                      title: "Preço (c/IVA a xx%)",
                                      isRequired: false,
                                      isNumber: true,
                                      initialValue:
                                          event.price?.toString() ?? "",
                                      onChanged: (value) {
                                        setState(() {
                                          if (value != null) {
                                            event.price =
                                                double.tryParse(value);
                                          }
                                        });
                                      }),
                                ]),
                            SizedBox(height: space),
                            BasicTextForm(
                              title: "Equipamentos",
                              isRequired: false,
                              initialValue: event.equipment,
                              onChanged: (value) {
                                setState(() {
                                  event.equipment = value;
                                });
                              },
                            ),
                            SizedBox(height: space),
                            EmployeeCheckboxList(
                              event: event,
                              constraints: constraints,
                              allEmployeesList: event.employees,
                              onChanged: (List<Employee> checkedEmployees) {
                                setState(() {
                                  event.employees = checkedEmployees;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: BasicTextForm(
                            title: "Observações",
                            isRequired: false,
                            initialValue: event.observations,
                            onChanged: (value) {
                              setState(() {
                                event.observations = value;
                              });
                            }),
                      ),
                    ),
                    event.eventType != null
                        ? Column(
                            children: [
                              SizedBox(height: space),
                              const Card(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text("Tarefas associadas ao evento",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(), //TODO: passar availableEmployees

                    event.toDate.isBefore(DateTime.now())
                        ? Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: BasicTextForm(
                                  title: "Avaliação",
                                  isRequired: false,
                                  initialValue: event.evaluation,
                                  onChanged: (value) {
                                    setState(() {
                                      event.evaluation = value;
                                    });
                                  }),
                            ),
                          )
                        : Container(),
                    widget.event != null
                        ? CardViewDeleteButton(
                            buttonText: "Eliminar",
                            dialogTitleText: "Eliminar Evento",
                            contentText:
                                "Tem a certeza que pretende eliminar este evento?",
                            actionButtonText: "ELIMINAR",
                            onPressed: () async => eventLogic
                                .remove(widget.event, event)
                                .then(
                                  (_) => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  ),
                                ),
                          )
                        : Container()
                  ],
                ),
              ),
            );
          },
        ));
  }

  handleValidation() {
    if (event.eventType == null || event.eventType == "") {
      callDialogBox("o tipo evento");
      return;
    }
    if (event.room == null || event.room == "") {
      callDialogBox("o espaço onde decorre o evento");
      return;
    }
    if (event.employees == null || event.employees!.isNotEmpty) {
      callDialogBox("os funcionários que participam no evento");
      return;
    }

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
  }

  callDialogBox(text) {
    return showDialogBox(
      context: context,
      title: "Formulário Incompleto",
      content: "Por favor selecione $text",
      confirmText: "OK",
      OnPressedConfirm: () => Navigator.of(context).pop(),
    );
  }

  goHome() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
}
