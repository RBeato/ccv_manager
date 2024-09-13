import 'package:ccv_manager/events_widget/common/row_column_mobile_conditional_builder.dart';
import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/models/personal_work_register/mini_event.dart';
import 'package:ccv_manager/providers/available_employee_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_offday_editing_page/form_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/check_is_mobile.dart';
import '../../common/form_fields/date_time_field.dart';
import '../../constants/constants.dart';
import '../../models/cultural_events/cultural_event.dart';

class EmployeeCheckboxList extends ConsumerStatefulWidget {
  const EmployeeCheckboxList({
    required this.onChanged,
    this.constraints,
    this.allEmployeesList,
    this.assignedEmployee,
    this.needsTimeRegister,
    this.allowsOnlyOneEmployee = false,
    this.event,
  });

  final Function(List<Employee> checkEmployees)? onChanged;
  final List<Employee>? allEmployeesList;
  final BoxConstraints? constraints;
  final CulturalEvent? event;
  final bool? needsTimeRegister;
  final bool allowsOnlyOneEmployee;
  final Employee? assignedEmployee;

  @override
  _EmployeeCheckboxListState createState() => _EmployeeCheckboxListState();
}

class _EmployeeCheckboxListState extends ConsumerState<EmployeeCheckboxList> {
  final Map<Employee, bool> _employeeValues = {};
  List<Employee> checkedEmployees = [];
  late List<Employee> availableEmployees;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();

    var av = ref.read(availableEmployeesProvider.notifier).filterEmployees(
        MiniEvent(
            category: SelectedCategory.task,
            type: Constants.hours,
            from: DateTime.now(),
            to: DateTime.now().add(const Duration(minutes: 30))));

    availableEmployees = av;

    if (widget.allEmployeesList != null) {
      for (var employee in availableEmployees) {
        _employeeValues[employee] =
            widget.allEmployeesList!.any((e) => e.email == employee.email);
      }
    } else {
      for (var employee in availableEmployees) {
        _employeeValues[employee] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.watch(miniEventProvider);
    availableEmployees = ref.watch(availableEmployeesProvider);
    //TODO: Should be all employees instead of available employees

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Funcionários disponíveis',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: availableEmployees.length,
          itemBuilder: (BuildContext context, int index) {
            final employee = availableEmployees[index];
            return Container(
              decoration: _employeeValues[employee] == true &&
                      widget.needsTimeRegister != false
                  ? BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )
                  : null,
              child: Column(
                children: [
                  CheckboxListTile(
                      title: Text(
                        employee.name,
                        style: TextStyle(
                            fontWeight: _employeeValues[employee] == true
                                ? FontWeight.w600
                                : null),
                      ),
                      value: _employeeValues[employee],
                      onChanged: (bool? value) =>
                          getEmployees(value, employee)),
                  _employeeValues[employee] == true &&
                          widget.needsTimeRegister != false
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ConditionalParentWidget(
                            condition: isMobile(widget.constraints),
                            children: [
                              DateTimePicker(
                                header: 'Início:',
                                needsHour: true,
                                initialDateTime:
                                    employee.employeeAppointment?.fromDate ??
                                        widget.event?.fromDate ??
                                        DateTime.now(),
                                onDateTimeChanged: (newDateTime) {
                                  employee.employeeAppointment?.fromDate =
                                      newDateTime;
                                },
                              ),
                              DateTimePicker(
                                header: 'Fim:',
                                needsHour: true,
                                initialDateTime:
                                    employee.employeeAppointment?.toDate ??
                                        widget.event?.toDate ??
                                        DateTime.now()
                                            .add(const Duration(minutes: 30)),
                                onDateTimeChanged: (newDateTime) {
                                  employee.employeeAppointment?.toDate =
                                      newDateTime;
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  getEmployees(value, employee) {
    setState(() {
      if (widget.allowsOnlyOneEmployee) {
        // Reset all other checkboxes to false
        for (var emp in _employeeValues.keys) {
          _employeeValues[emp] = false;
        }
        // Set the selected checkbox to true
        _employeeValues[employee] = value!;
      } else {
        _employeeValues[employee] = value!;
      }
    });

    // Rest of the code remains the same
    checkedEmployees = _employeeValues.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    if (widget.onChanged != null) {
      widget.onChanged!(checkedEmployees);
    }
  }
}
