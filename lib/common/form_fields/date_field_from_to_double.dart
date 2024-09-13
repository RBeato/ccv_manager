import 'package:ccv_manager/common/form_fields/date_time_field.dart';
import 'package:ccv_manager/common/provider/date_time_field_from_to_provider.dart';
import 'package:ccv_manager/models/date_time_from_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateFieldsFromTo extends ConsumerStatefulWidget {
  const DateFieldsFromTo(
      {super.key, this.fromDate, this.toDate, this.needsHour});
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool? needsHour;

  @override
  ConsumerState<DateFieldsFromTo> createState() => _DateFieldsFromToState();
}

class _DateFieldsFromToState extends ConsumerState<DateFieldsFromTo> {
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    fromDate = widget.fromDate ?? DateTime.now();
    toDate = widget.toDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: DateTimePicker(
            header: 'Início:',
            needsHour: widget.needsHour ?? true,
            initialDateTime: fromDate,
            onDateTimeChanged: (newDateTime) {
              fromDate = newDateTime;
              if (toDate.isBefore(fromDate)) {
                toDate = newDateTime;
              }
              ref.read(dateTimeFromToProvider.notifier).update(
                  (state) => DateTimeFromTo(from: fromDate, to: toDate));
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 20),
        DateTimePicker(
          header: 'Fim:',
          needsHour: widget.needsHour ?? true,
          initialDateTime: toDate,
          onDateTimeChanged: (newDateTime) {
            toDate = newDateTime;
            if (toDate.isBefore(fromDate)) {
              fromDate = newDateTime;
            }
            ref
                .read(dateTimeFromToProvider.notifier)
                .update((state) => DateTimeFromTo(from: fromDate, to: toDate));
            setState(() {});
          },
        ),
      ],
    );
  }
}
