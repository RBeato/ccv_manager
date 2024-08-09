import 'package:ccv_manager/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
// ignore: must_be_immutable
class CalendarEvent extends Equatable {
  CalendarEvent({
    this.id,
    this.parentId,
    this.title,
    required this.fromDate, //start of event independent of   , if lasts for several days create several daily events until 'toDate'
    required this.toDate,
    this.isAllDay = false,
    this.eventType,
    this.observations,
    this.eventCreator,
    this.eventCreationDate,
    this.lastEditedBy,
    this.lastEditedOn,
    this.isCompleted,
  }) {
    getBackgroundColor();
  }

  /// Event name which is equivalent to subject property of [Appointment].
  String? title;

  /// From which is equivalent to start time property of [Appointment].
  DateTime fromDate;

  /// To which is equivalent to end time property of [Appointment].
  DateTime toDate;

  /// Background which is equivalent to color property of [Appointment].
  late Color backgroundColor;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

  //*added
  String? id;
  String? parentId;
  EventType? eventType;

  String? observations;
  String? eventCreator;
  String? lastEditedBy;
  DateTime? lastEditedOn;
  DateTime? eventCreationDate;
  bool? isCompleted;

  getBackgroundColor() {
    backgroundColor = Colors.teal;
    if (eventType != null) {
      switch (eventType) {
        case EventType.meeting:
          backgroundColor = Colors.blue;
          break;
        case EventType.activity:
          backgroundColor = Colors.green;
          break;
        case EventType.concert:
          backgroundColor = Colors.red;
          break;
        case EventType.theater:
          backgroundColor = Colors.purple;
          break;
        case EventType.dance:
          backgroundColor = Colors.orange;
          break;
        case EventType.guidedVisit:
          backgroundColor = Colors.yellow;
          break;
        case EventType.roomReservation:
          backgroundColor = Colors.pink;
          break;
        case EventType.shift:
          backgroundColor = Colors.teal;
          break;
        case EventType.offDay:
          backgroundColor = Colors.grey;
          break;
        case EventType.hostelReservation:
          backgroundColor = const Color.fromARGB(255, 185, 128, 147);
          break;
        default:
          backgroundColor = Colors.white;
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'eventName': title,
      'from': fromDate.toString(),
      'to': toDate.toString(),
      'isAllDay': isAllDay,
      'eventType': Constants.eventCategoryToString[eventType],
      'observations': observations,
      'eventCreator': eventCreator,
      'lastEditedBy': lastEditedBy,
      'lastEditedOn': lastEditedOn.toString(),
      'eventCreationDate': eventCreationDate.toString(),
      'isCompleted': isCompleted ?? '',
    };
  }

  CalendarEvent.fromSnapshot(DocumentSnapshot doc)
      : id = doc.id,
        parentId = doc['parentId'],
        title = doc['eventName'],
        fromDate = DateTime.parse(doc['from']),
        toDate = DateTime.parse(doc['to']),
        isAllDay = doc['isAllDay'],
        eventType = doc['eventType'] != null
            ? Constants.eventCategoryToString.entries
                .firstWhere((element) => element.value == doc['eventType'])
                .key
            : null,
        observations = doc['observations'],
        eventCreator = doc['eventCreator'],
        lastEditedBy = doc['lastEditedBy'],
        lastEditedOn = DateTime.tryParse(doc['lastEditedOn']),
        eventCreationDate = DateTime.tryParse(doc['eventCreationDate']),
        isCompleted = doc['isCompleted'] == "" || doc['isCompleted'] == null
            ? false
            : doc['isCompleted'] {
    getBackgroundColor();
  }

  CalendarEvent copyWith(
      {String? id,
      String? parentId,
      String? eventName,
      DateTime? from,
      DateTime? to,
      Color? backgroundColor,
      bool? isAllDay,
      EventType? eventType,
      String? observations,
      String? eventCreator,
      String? recurrenceRule,
      String? lastEditedBy,
      DateTime? lastEditedOn,
      DateTime? eventCreationDate,
      bool? isCompleted}) {
    return CalendarEvent(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      eventType: eventType ?? this.eventType,
      fromDate: from ?? fromDate,
      toDate: to ?? toDate,
      title: eventName ?? title,
      isAllDay: isAllDay ?? this.isAllDay,
      observations: observations ?? this.observations,
      eventCreator: eventCreator ?? this.eventCreator,
      lastEditedBy: lastEditedBy ?? this.lastEditedBy,
      lastEditedOn: lastEditedOn ?? this.lastEditedOn,
      eventCreationDate: eventCreationDate ?? this.eventCreationDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props =>
      [title, observations, fromDate, toDate, backgroundColor, isAllDay];
}
