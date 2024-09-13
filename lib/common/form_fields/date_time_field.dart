import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final String header;
  final DateTime initialDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;
  final bool? needsHour;
  final bool? needsDate;

  const DateTimePicker({
    required this.header,
    required this.initialDateTime,
    required this.onDateTimeChanged,
    this.needsHour = true,
    this.needsDate = true,
  });

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  @override
  void didUpdateWidget(covariant DateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDateTime != oldWidget.initialDateTime) {
      _selectedDateTime = widget.initialDateTime;
    }
  }

  Future<void> _pickFromDateTime({required bool pickDate}) async {
    final now = DateTime.now();
    final initialDateTime = _selectedDateTime;
    DateTime newDateTime;

    if (widget.needsDate == true) {
      _selectedDateTime = await showDatePicker(
              context: context,
              initialDate: initialDateTime,
              firstDate: DateTime(now.year - 90),
              lastDate: now.add(const Duration(days: 365))) ??
          DateTime.now();
    }

    if (widget.needsHour == true) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDateTime),
      );

      if (time == null) return;

      newDateTime = DateTime(_selectedDateTime.year, _selectedDateTime.month,
          _selectedDateTime.day, time.hour, time.minute);
    } else {
      newDateTime = DateTime(_selectedDateTime.year, _selectedDateTime.month,
          _selectedDateTime.day);
    }

    setState(() {
      _selectedDateTime = newDateTime;
    });
    widget.onDateTimeChanged(newDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return buildHeader(
      header: widget.header,
      child: widget.needsDate == true && widget.needsHour == true
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: buildDropdownField(
                    text: dateFormat.format(_selectedDateTime),
                    onClicked: () => _pickFromDateTime(pickDate: true),
                  ),
                ),
                Expanded(
                  child: buildDropdownField(
                    text: timeFormat.format(_selectedDateTime),
                    onClicked: () => _pickFromDateTime(pickDate: false),
                  ),
                ),
              ],
            )
          : widget.needsDate == false && widget.needsHour == true
              ? buildDropdownField(
                  text: timeFormat.format(_selectedDateTime),
                  onClicked: () => _pickFromDateTime(pickDate: false),
                )
              : widget.needsDate == true && widget.needsHour == false
                  ? buildDropdownField(
                      text: dateFormat.format(_selectedDateTime),
                      onClicked: () => _pickFromDateTime(pickDate: true),
                    )
                  : const Text("Error"),
    );
  }
}

Widget buildHeader({required String header, required Widget child}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        header,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black54,
        ),
      ),
      const SizedBox(height: 8),
      child,
    ],
  );
}

Widget buildDropdownField(
    {required String text, required VoidCallback onClicked}) {
  return ListTile(
    title: Text(text),
    trailing: const Icon(Icons.arrow_drop_down),
    onTap: onClicked,
  );
}
