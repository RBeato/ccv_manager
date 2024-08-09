import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/form_fields/date_time_field.dart';
import '../../models/personal_work_register/mini_event.dart';
import '../../providers/available_employee_provider.dart';
import '../shift_offday_editing_page/form_switch.dart';

class AllDayShiftDateForm extends ConsumerStatefulWidget {
  const AllDayShiftDateForm({this.dates, required this.category, super.key});
  final SelectedCategory category;
  final List<MiniEvent>? dates;

  @override
  ConsumerState<AllDayShiftDateForm> createState() => _HolidayInputFormState();
}

class _HolidayInputFormState extends ConsumerState<AllDayShiftDateForm> {
  late List<MiniEvent> dates;

  @override
  void initState() {
    super.initState();
    dates = widget.dates ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: DateTimePicker(
            header: 'Selecione o dia: ',
            needsHour: false,
            needsDate: true,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (newDateTime) {
              DateTimeUtils.createDailyShiftMiniEvents(
                  newDateTime, widget.category);
              ref.read(miniEventsProvider.notifier).update((state) => dates);
              ref
                  .read(availableEmployeesProvider.notifier)
                  .filterEmployees(dates.first);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
