import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/check_is_mobile.dart';
import '../../common/form_fields/date_time_field.dart';
import '../../constants/constants.dart';
import '../../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../../models/personal_work_register/mini_event.dart';
import '../../providers/available_employee_provider.dart';
import '../../utils/date_time_utils.dart';
import '../common/show_date_error_warning.dart';
import '../shift_offday_editing_page/form_switch.dart';

class AbsenceSeveralDaysInputForm extends ConsumerStatefulWidget {
  const AbsenceSeveralDaysInputForm(
      {this.dates, required this.category, this.constraints, super.key});
  final SelectedCategory category;
  final List<MiniEvent>? dates;
  final BoxConstraints? constraints;

  @override
  ConsumerState<AbsenceSeveralDaysInputForm> createState() =>
      _AbsenceSeveralDaysInputFormState();
}

class _AbsenceSeveralDaysInputFormState
    extends ConsumerState<AbsenceSeveralDaysInputForm> {
  late List<MiniEvent> dates;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  late MiniEvent masterEvent;

  @override
  void initState() {
    super.initState();
    dates = widget.dates ?? [];
    masterEvent = MiniEvent(
      from: DateTime.now(),
      to: DateTime.now(),
      type: Constants.hours,
      category: widget.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalParentWidget(
      condition: isMobile(widget.constraints),
      children: [
        DateTimePicker(
          header: 'Desde: ',
          needsHour: false,
          needsDate: true,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (newDateTime) {
            setState(() {
              masterEvent =
                  DateTimeUtils.checkFromIsBeforeTo(newDateTime, masterEvent);
              DateTimeUtils.createMiniEvents(
                  masterEvent, Constants.holiday, widget.category);
            });
          },
        ),
        DateTimePicker(
          header: 'Até: ',
          needsHour: false,
          needsDate: true,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (newDateTime) {
            setState(() {
              masterEvent =
                  DateTimeUtils.checkToIsAfterFrom(newDateTime, masterEvent)
                      .first;

              DateTimeUtils.checkToIsAfterFrom(newDateTime, masterEvent).last ==
                      false
                  ? showWarning(
                      "A data de final não pode ser anterior à data de início!",
                      context,
                    )
                  : null;
              DateTimeUtils.createMiniEvents(
                  masterEvent, Constants.holiday, widget.category);
              print(ref.read(availableEmployeesProvider));
            });
          },
        ),
      ],
    );
  }
}
