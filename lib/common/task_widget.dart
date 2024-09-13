import 'package:ccv_manager/events_widget/event_data_source.dart';
import 'package:ccv_manager/models/library_models/hostel_page/hostel_entry_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants/constants.dart';
import '../events_widget/event_view/event_view_page.dart';
import '../home_page/provider/tile_selection_provider.dart';
import '../shift_off_day_widget/shift_off_day_view/shift_off_day_view_page.dart';
import 'provider/task_widget_data_provider.dart';

class TaskWidget extends ConsumerStatefulWidget {
  const TaskWidget({super.key, this.details});
  final CalendarTapDetails? details;

  @override
  TaskWidgetState createState() => TaskWidgetState();
}

class TaskWidgetState extends ConsumerState<TaskWidget> {
  PageSelection? page;

  @override
  void initState() {
    super.initState();
    page = ref.read(pageSelectionProvider);
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = ref.watch(todoDataProvider);

    if (selectedEvents.isEmpty) {
      return Center(
          child: Text("Nenhum evento para esta data",
              style: Theme.of(context).textTheme.bodyMedium));
    }

    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(selectedEvents),
      initialDisplayDate:
          widget.details == null ? DateTime.now() : widget.details!.date!,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeFormat: 'HH:mm',
      ),
      appointmentBuilder: (context, details) =>
          appointmentBuilder(context, details, page),
      onTap: (details) {
        handleTap(details);
      },
      headerStyle: CalendarHeaderStyle(
        textStyle: const TextStyle().copyWith(color: Colors.black45),
        textAlign: TextAlign.left,
        backgroundColor: Colors.white, // Add padding here
      ),
    );
  }

  handleTap(details) {
    if (details.appointments == null) return;
    if (page == PageSelection.events) {
      final event = details.appointments!.first;

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EventViewPage(event)));
    }
    if (page == PageSelection.shiftsAndOffDays) {
      final event = details.appointments!.first;

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShiftOffDayViewingPage(event)));
    }
    if (page == PageSelection.hostel) {
      final event = details.appointments!.first;

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HostelEntryViewPage(event)));
    } else {
      return;
    }
  }
}

Widget appointmentBuilder(
  BuildContext context,
  CalendarAppointmentDetails details,
  PageSelection? page,
) {
  final event = details.appointments.first;
  return Container(
    width: details.bounds.width,
    height: details.bounds.height,
    decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8)),
    child: Text(
      page == PageSelection.shiftsAndOffDays
          ? event.assignedEmployee.name ?? ''
          : event.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
