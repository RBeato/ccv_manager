import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:ccv_manager/models/library_models/hostel_page/providers/hostel_data_provider.dart';
import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/models/personal_work_register/mini_event.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_offday_editing_page/form_switch.dart';
import 'package:ccv_manager/shift_off_day_widget/types/custom_event_input.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_offday_editing_page/weekend_small_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/appbar_editing_save_button.dart';
import '../../../../common/form_fields/basic_text_form.dart';
import '../../../../providers/available_employee_provider.dart';
import '../../hostel_register/hostel_register.dart';

class HostelEntryForm extends ConsumerStatefulWidget {
  const HostelEntryForm({Key? key, this.event}) : super(key: key);

  final HostelRegisterEvent? event;

  @override
  HostelEntryFormState createState() => HostelEntryFormState();
}

class HostelEntryFormState extends ConsumerState<HostelEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  String? observations;
  String? name;
  late List<Employee> assignedEmployees;
  late MiniEvent miniEvent;

  final String _selectedValue = Constants.hours;
  List calculatedDates = [];
  List<MiniEvent> dates = [];

  @override
  void initState() {
    super.initState();

    var mini = ref.read(miniEventsProvider);

    if (mini != null && mini.isNotEmpty) {
      miniEvent = ref.read(miniEventsProvider)!.first;
    } else {
      miniEvent = MiniEvent(
          category: SelectedCategory.hostelRegister,
          type: "Registo de entrada no Albergue");
    }

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 1));
    } else {
      titleController.text = widget.event!.title ?? "No name";
      fromDate = widget.event!.fromDate;
      toDate = widget.event!.toDate;
      name = widget.event!.title;
      observations = widget.event!.observations;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(availableEmployeesProvider);

    double space = 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registar entrada no Albergue"),
        leading: const CloseButton(),
        actions: buildEditingActions(saveForm),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BasicTextForm(
                      title: "Nome do Peregrino",
                      isRequired: false,
                      initialValue: name,
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomEventInputForm(
                          text: "Data de entrada",
                          needsOneFieldOnly: true,
                          type: Constants.hostelReservation,
                          category: SelectedCategory.hostelRegister,
                        ),
                        dates.isNotEmpty
                            ? SelectedDatesContainer(dates, _selectedValue)
                            : Container(),
                        Container(),
                        SizedBox(height: space),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BasicTextForm(
                      title: "Observações",
                      initialValue: observations,
                      isRequired: false,
                      onChanged: (value) {
                        observations = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDateSelectionWidgets() {
    return const CustomEventInputForm(
      type: Constants.hostelReservation,
      category: SelectedCategory.hostelRegister,
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    print("mini event: ${ref.read(miniEventsProvider)}");

    HostelRegisterEvent event = HostelRegisterEvent(
      id: widget.event?.id,
      eventName: name,
      fromDate: miniEvent.from ?? DateTime.now(),
      toDate: DateTime.now().add(const Duration(minutes: 90)),
      eventType: EventType.hostelReservation,
      type: "Registo de entrada no Albergue",
      observations: observations ?? "",
    );

    final isEditing = widget.event != null;

    if (isEditing) {
      ref.read(hostelProvider.notifier).edit(event);
      Navigator.of(context).pop();
    } else {
      ref.read(hostelProvider.notifier).add(event);
      Navigator.of(context).pop();
    }
  }
}
