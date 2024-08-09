import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<CalendarEvent> source) {
    appointments = source;
  }

  CalendarEvent getEvent(int index) => appointments![index] as CalendarEvent;

  @override
  DateTime getStartTime(int index) => getEvent(index).fromDate;

  @override
  DateTime getEndTime(int index) => getEvent(index).toDate;

  @override
  String getSubject(int index) => getEvent(index).title ?? "No name";

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;

  @override
  String getNotes(int index) => getEvent(index).observations ?? "";
}
