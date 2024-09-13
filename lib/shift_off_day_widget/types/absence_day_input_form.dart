import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/form_fields/date_time_field.dart';
import '../../models/personal_work_register/mini_event.dart';
import '../../utils/date_time_utils.dart';
import '../shift_offday_editing_page/form_switch.dart';

class AbsenceDayInputForm extends ConsumerStatefulWidget {
  const AbsenceDayInputForm({this.dates, required this.category, super.key});
  final SelectedCategory category;
  final List<MiniEvent>? dates;

  @override
  ConsumerState<AbsenceDayInputForm> createState() => _HolidayInputFormState();
}

class _HolidayInputFormState extends ConsumerState<AbsenceDayInputForm> {
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
              dates = DateTimeUtils.createWholeDayMiniEvent(
                newDateTime,
                widget.category,
              );
              ref.read(miniEventsProvider.notifier).update((state) => dates);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
