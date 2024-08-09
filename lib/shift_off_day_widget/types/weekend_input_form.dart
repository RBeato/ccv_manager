import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:ccv_manager/providers/available_employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/form_fields/date_time_field.dart';
import '../../models/personal_work_register/mini_event.dart';
import '../../utils/date_time_utils.dart';
import '../shift_offday_editing_page/form_switch.dart';

class WeekendInputForm extends ConsumerStatefulWidget {
  const WeekendInputForm(
      {required this.dates, required this.category, super.key});
  final SelectedCategory category;
  final List<MiniEvent> dates;

  @override
  ConsumerState<WeekendInputForm> createState() => _WeekendInputFormState();
}

class _WeekendInputFormState extends ConsumerState<WeekendInputForm> {
  List dates = [];

  @override
  void initState() {
    super.initState();

    dates = widget.dates;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: DateTimePicker(
                header: 'Selecione um dia do fim de semana pretendido: ',
                needsHour: false,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (newDateTime) {
                  setState(() {
                    dates = DateTimeUtils.createWeekendDatesMiniEvents(
                        newDateTime, widget.category);
                  });
                  ref
                      .read(miniEventsProvider.notifier)
                      .update((state) => dates[0]);
                  ref
                      .read(availableEmployeesProvider.notifier)
                      .filterEmployees(dates.first);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
