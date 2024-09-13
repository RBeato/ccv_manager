import 'package:ccv_manager/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/employees_radio_button_list.dart';
import '../../shift_off_day_widget/shift_offday_editing_page/form_switch.dart';

class EmployeeSingleSelectionRadioButtons extends ConsumerStatefulWidget {
  const EmployeeSingleSelectionRadioButtons(
      {required this.availableEmployees,
      required this.onChanged,
      required this.category,
      required this.type,
      this.initialValue});

  final List<Employee> availableEmployees;
  final Function? onChanged;
  final Employee? initialValue;
  final SelectedCategory category;
  final String type;

  @override
  _EmployeeSingleSelectionRadioButtonsState createState() =>
      _EmployeeSingleSelectionRadioButtonsState();
}

class _EmployeeSingleSelectionRadioButtonsState
    extends ConsumerState<EmployeeSingleSelectionRadioButtons> {
  late Employee selectedEmployee;
  List<Employee> availableEmployees = [];

  @override
  void initState() {
    super.initState();
    availableEmployees = widget.availableEmployees;
    selectedEmployee = widget.initialValue ?? availableEmployees.first;
  }

  @override
  Widget build(BuildContext context) {
    return EmployeesRadioButtonList(
      employees: availableEmployees,
      onChanged: (Employee? value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      initialValue: selectedEmployee,
    );
  }
}
