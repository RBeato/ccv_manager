import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/events_widget/event_data_source.dart';
import 'package:ccv_manager/common/task_widget.dart';
import 'package:ccv_manager/models/hostel_register/hostel_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../home_page/provider/filters_provider.dart';
import '../home_page/provider/tile_selection_provider.dart';
import '../models/calendar_event/calendar_event.dart';
import '../models/personal_work_register/personal_work_register.dart';
import '../models/visitors/visitor_register_event.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  const CalendarWidget(this.data, {super.key});
  final List data;

  @override
  ConsumerState<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget> {
  List<CalendarEvent> events = [];
  bool isDataLoaded = false;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    events = List<CalendarEvent>.from(widget.data.reversed);
    isDataLoaded = true; // Set flag to true once data is loaded
    _opacity = 1.0; // <-- Set opacity to 1.0 when data is loaded
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(filtersProvider);

    if (!isDataLoaded) {
      return const Center(
        child: Text("Loading"),
      );
    } else {
      return AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: calendar(events),
      );
    }
  }

  Widget calendar(data) => SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      dataSource: EventDataSource(events),
      allowAppointmentResize: false,
      showCurrentTimeIndicator: true,
      showNavigationArrow: true,
      monthCellBuilder: monthCellBuilder,
      onTap: (details) {
        final page = ref.read(pageSelectionProvider);
        if (page == PageSelection.events ||
            page == PageSelection.shiftsAndOffDays ||
            page == PageSelection.hostel) {
          showModalBottomSheet(
              context: context,
              builder: (context) => TaskWidget(details: details));
        }
      });

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    List<Widget> appointmentTexts = [];
    if (details.appointments.isNotEmpty) {
      if (ref.read(pageSelectionProvider) == PageSelection.visitorsRegister) {
        String text = "";
        for (int i = 0; i < details.appointments.length; i++) {
          VisitorRegisterEvent appointment =
              details.appointments[i] as VisitorRegisterEvent;
          text +=
              "${appointment.visitorCounter.toString()} visitantes"; // ${' ' * 50}";
        }
        appointmentTexts.add(cellText(text, Colors.grey));
      }
      if (ref.read(pageSelectionProvider) == PageSelection.hostel) {
        List t = [];
        for (int i = 0; i < details.appointments.length; i++) {
          HostelRegisterEvent appointment =
              details.appointments[i] as HostelRegisterEvent;
          t.add("${appointment.title} "); // ${' ' * 50}";
        }
        appointmentTexts = [
          marquee(t.join(", "), Colors.grey),
        ];
      }
      if (ref.read(pageSelectionProvider) == PageSelection.events) {
        String text = "";
        for (int i = 0; i < details.appointments.length; i++) {
          CalendarEvent appointment = details.appointments[i] as CalendarEvent;
          text += "${appointment.title.toString()} \n"; // ${' ' * 50}\n";
        }
        appointmentTexts.add(cellText(text, Colors.grey));
      }
      if (ref.read(pageSelectionProvider) == PageSelection.shiftsAndOffDays) {
        //WITH MARQUEE
        List<String> tempShifts = [];
        List<String> tempOffDays = [];

        ///
        for (int i = 0; i < details.appointments.length; i++) {
          PersonalWorkRegisterEvent appointment =
              details.appointments[i] as PersonalWorkRegisterEvent;
          String text = appointment.assignedEmployee?.name ?? "Sem nome";

          //WITH MARQUEE
          if (appointment.eventType == EventType.shift) {
            tempShifts.add(text);
          } else {
            tempOffDays.add(text);
          }
        }
        //WITH MARQUEE
        appointmentTexts = [
          marquee(tempShifts.join(", "), Colors.teal),
          marquee(tempOffDays.join(", "), Colors.grey),
        ];
        //
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12, width: 0.2),
      ),
      child: Stack(
        children: [
          cellDateText(details),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 20.0),
              ...appointmentTexts.map(((e) => Flexible(child: e))),
              const SizedBox(height: 20.0),
            ]),
          ),
        ],
      ),
    );
  }

  Widget cellDateText(MonthCellDetails details) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.2),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(details.date.day.toString(),
              style: details.date.day == DateTime.now().day
                  ? const TextStyle(
                      color: Colors.blue,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600)
                  : const TextStyle(color: Colors.black45, fontSize: 12.0)),
        ));
  }

  Widget cellText(text, color) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: color),
      );

  Widget marquee(text, color) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Marquee(
          text: text + ' ' * 20,
          style: TextStyle(color: color),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          blankSpace: 30.0,
          velocity: 150.0, //100.0,
          pauseAfterRound: const Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: const Duration(milliseconds: 200),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 200),
          decelerationCurve: Curves.easeOut,
          fadingEdgeEndFraction: 0.4,
          fadingEdgeStartFraction: 0.4,
          showFadingOnlyWhenScrolling: true,
        ),
      );
}
