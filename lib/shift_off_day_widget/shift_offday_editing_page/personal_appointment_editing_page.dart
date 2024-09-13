import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:ccv_manager/home_page/home/home_page.dart';
import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/models/personal_work_register/mini_event.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/category_type_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_offday_editing_page/type_selection.dart';
import 'package:ccv_manager/shift_off_day_widget/types/absence_several_days_input_form.dart';
import 'package:ccv_manager/shift_off_day_widget/types/custom_event_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/appbar_editing_save_button.dart';
import '../../common/form_fields/basic_text_form.dart';
import '../../events_widget/common/employee_single_selection_radio.dart';
import '../../models/calendar_event/calendar_event.dart';
import '../../providers/available_employee_provider.dart';
import '../provider/personal_appointment_logic_provider.dart';
import '../types/absence_day_input_form.dart';
import '../types/weekend_input_form.dart';
import 'all_day_shift.dart';
import 'form_switch.dart';

class PersonalAppointmentPage extends ConsumerStatefulWidget {
  const PersonalAppointmentPage(this.event, {Key? key}) : super(key: key);

  final CalendarEvent? event;

  @override
  ShiftEditingState createState() => ShiftEditingState();
}

class ShiftEditingState extends ConsumerState<PersonalAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  String? observations;
  late List<Employee> availableEmployees;
  List<Employee>? assignedEmployees;
  String _selectedValue = Constants.hours;
  List calculatedDates = [];
  List<MiniEvent> dates = [];
  DateTime date = DateTime.now();
  BoxConstraints? contraints;
  late SelectedCategory _selectedCategory;

  void handleSwitchChange(
      SelectedCategory value, PersonalAppointmentLogic personalAppointment) {
    ref.read(shiftAbsenceCategoryProvider.notifier).update((state) => value);
    setState(() {
      _selectedCategory = value;
      _selectedValue = Constants.hours;
      dates.clear();

      personalAppointment.updateMiniEvents(
          selectedValue: _selectedValue,
          date: date,
          selectedCategory: _selectedCategory,
          dates: dates);
    });
  }

  @override
  void initState() {
    super.initState();

    date = DateTime.now();

    _selectedCategory = ref.read(shiftAbsenceCategoryProvider);

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 1));
    } else {
      titleController.text = widget.event!.title ?? "No name";
      fromDate = widget.event!.fromDate;
      toDate = widget.event!.toDate;
    }

    dates.add(MiniEvent(
      from: fromDate,
      to: toDate,
      type: Constants.hours,
      category: _selectedCategory,
    ));

    getAvailableEmployees();
  }

  getAvailableEmployees() {
    availableEmployees = ref
        .read(availableEmployeesProvider.notifier)
        .filterEmployees(dates.first);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    availableEmployees = ref.watch(availableEmployeesProvider);
    ref.watch(miniEventsProvider);
    final personalAppointment = ref.watch(personalAppointmentProvider);
    double space = 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar turno/ausência"),
        leading: const CloseButton(),
        actions: buildEditingActions(() => personalAppointment
            .saveForm(
                widgetEvent: widget.event,
                formKey: _formKey,
                selectedValue: _selectedValue,
                dates: dates,
                observations: observations,
                assignedEmployees: assignedEmployees,
                availableEmployees: availableEmployees,
                selectedCategory: _selectedCategory)
            .then((_) => goHome())),
        backgroundColor: Colors.teal,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FormSwitchType(
                    onChanged: (value) =>
                        handleSwitchChange(value, personalAppointment),
                  ),
                  TypeSelection(
                    items: _selectedCategory == SelectedCategory.absence
                        ? Constants.offDayTypes
                        : Constants.shiftTypes,
                    title: _selectedCategory == SelectedCategory.absence
                        ? "Tipo de ausência"
                        : "Tipo de turno",
                    onPressed: (value) {
                      setState(() {
                        _selectedValue = value!;
                        dates.clear();
                      });
                      personalAppointment.updateMiniEvents(
                          selectedValue: _selectedValue,
                          date: date,
                          selectedCategory: _selectedCategory,
                          dates: dates);
                    },
                    selectedValue: _selectedValue,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          buildDateSelectionWidgets(constraints: constraints),
                          SizedBox(height: space),
                          EmployeeSingleSelectionRadioButtons(
                            availableEmployees: availableEmployees,
                            type: _selectedValue,
                            category: _selectedCategory,
                            onChanged: (Employee checkedEmployee) {
                              assignedEmployees = [checkedEmployee];
                              print(checkedEmployee);
                            },
                          )
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
        );
      }),
    );
  }

  buildDateSelectionWidgets({BoxConstraints? constraints}) {
    if (_selectedCategory == SelectedCategory.absence) {
      if (_selectedValue == Constants.hours ||
          _selectedValue == Constants.medicalAppointment) {
        return CustomEventInputForm(
          dates: dates,
          type: _selectedValue,
          category: SelectedCategory.absence,
        );
      } else if (_selectedValue == Constants.offDay) {
        return AbsenceDayInputForm(
          dates: dates,
          category: SelectedCategory.absence,
        );
      } else if (_selectedValue == Constants.vacation ||
          _selectedValue == Constants.medicalCertificate) {
        return AbsenceSeveralDaysInputForm(
          constraints: constraints,
          dates: dates,
          category: SelectedCategory.absence,
        );
      }
    }

    if (_selectedCategory == SelectedCategory.shift) {
      if (_selectedValue == Constants.hours) {
        return CustomEventInputForm(
          dates: dates,
          type: _selectedValue,
          category: SelectedCategory.shift,
        );
      } else if (_selectedValue == Constants.weekend) {
        return WeekendInputForm(
          dates: dates,
          category: SelectedCategory.shift,
        );
      } else if (_selectedValue == Constants.holiday) {
        return AllDayShiftDateForm(
          dates: dates,
          category: SelectedCategory.shift,
        );
      }
    }
  }

  goHome() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
}
