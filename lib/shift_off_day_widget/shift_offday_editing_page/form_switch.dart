import 'package:flutter/material.dart';

enum SelectedCategory { absence, shift, task, hostelRegister }

class FormSwitchType extends StatefulWidget {
  const FormSwitchType({required this.onChanged, super.key});

  final ValueChanged<SelectedCategory> onChanged;

  @override
  State<FormSwitchType> createState() => _FormSwitchTypeState();
}

class _FormSwitchTypeState extends State<FormSwitchType> {
  SelectedCategory _selectedOption = SelectedCategory.absence;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Radio(
                value: SelectedCategory.absence,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                    widget.onChanged(value);
                  });
                },
              ),
              title: const Text('Ausência'),
            ),
            ListTile(
              leading: Radio(
                value: SelectedCategory.shift,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                    widget.onChanged(value);
                  });
                },
              ),
              title: const Text('Turno'),
            ),
          ],
        ),
      ),
    );
  }
}
