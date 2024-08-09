import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:ccv_manager/providers/available_employee_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/category_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/form_fields/date_time_field.dart';
import '../../constants/constants.dart';
import '../../models/personal_work_register/mini_event.dart';
import '../../utils/date_time_utils.dart';
import '../shift_offday_editing_page/form_switch.dart';

class CustomEventInputForm extends ConsumerStatefulWidget {
  const CustomEventInputForm(
      {this.text = "Selecione o período pretendido",
      required this.type,
      this.needsOneFieldOnly = false,
      required this.category,
      this.dates,
      super.key});
  final bool needsOneFieldOnly;
  final String text;
  final List<MiniEvent>? dates;
  final String type;
  final SelectedCategory category;

  @override
  ConsumerState<CustomEventInputForm> createState() =>
      _CustomEventInputFormState();
}

class _CustomEventInputFormState extends ConsumerState<CustomEventInputForm> {
  late MiniEvent miniEvent;

  @override
  void initState() {
    super.initState();
    miniEvent = widget.dates?.first ??
        MiniEvent(
          from: DateTime.now(),
          to: DateTime.now().add(const Duration(minutes: 30)),
          type: Constants.hours,
          category: widget.category,
        );
    miniEvent =
        miniEvent.copyWith(category: ref.read(shiftAbsenceCategoryProvider));
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(miniEventsProvider);

    return Column(
      children: [
        DateTimePicker(
          header: widget.text,
          needsDate: true,
          needsHour: true,
          initialDateTime: miniEvent.from!,
          onDateTimeChanged: (newDateTime) {
            setState(() {
              miniEvent =
                  DateTimeUtils.checkFromIsBeforeTo(newDateTime, miniEvent);
            });

            ref
                .read(miniEventsProvider.notifier)
                .update((state) => [miniEvent]);

            ref
                .read(availableEmployeesProvider.notifier)
                .filterEmployees(miniEvent);

            print(ref.read(availableEmployeesProvider));
          },
        ),
        const SizedBox(width: 20.0),
        widget.needsOneFieldOnly == true
            ? Container()
            : DateTimePicker(
                header: 'Até:',
                needsHour: true,
                needsDate: false,
                initialDateTime: miniEvent.to!,
                onDateTimeChanged: (newDateTime) {
                  setState(() {
                    miniEvent =
                        DateTimeUtils.checkToIsAfterFrom(newDateTime, miniEvent)
                            .first;

                    ref
                        .read(miniEventsProvider.notifier)
                        .update((state) => [miniEvent]);

                    ref
                        .read(availableEmployeesProvider.notifier)
                        .filterEmployees(miniEvent);

                    print(ref.read(availableEmployeesProvider));
                  });
                },
              ),
      ],
    );
  }
}
