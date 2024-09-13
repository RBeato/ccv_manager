import 'package:flutter/material.dart';

import '../models/employee.dart';

class EmployeesRadioButtonList extends StatefulWidget {
  const EmployeesRadioButtonList(
      {required this.employees,
      this.initialValue,
      required this.onChanged,
      super.key});
  final List<Employee> employees;
  final Employee? initialValue;
  final Function onChanged;

  @override
  State<EmployeesRadioButtonList> createState() =>
      _EmployeesRadioButtonListState();
}

class _EmployeesRadioButtonListState extends State<EmployeesRadioButtonList> {
  late Employee initialValue;

  @override
  void initState() {
    super.initState();
    initialValue = widget.initialValue ?? widget.employees.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Funcionários:',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.employees.length,
          itemBuilder: (BuildContext context, int index) {
            final employee = widget.employees[index];
            return RadioListTile<Employee>(
                title: Text(employee.name),
                value: employee,
                groupValue: initialValue,
                onChanged: (value) {
                  setState(() {
                    initialValue = value!;
                  });
                  widget.onChanged(initialValue);
                });
          },
        ),
      ],
    );
  }
}
