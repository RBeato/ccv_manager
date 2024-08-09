import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:ccv_manager/models/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cultural_events/cultural_event.dart';

class TodoEvent extends CalendarEvent {
  String? description;
  String? requester;
  Employee? assignedEmployee;
  List<Employee>? employees;

  TodoEvent({
    this.description,
    this.requester,
    this.assignedEmployee,
    this.employees,
    String? id,
    String? parentId,
    String? title,
    required DateTime fromDate,
    required DateTime toDate,
    bool isAllDay = false,
    EventType? eventType,
    String? observations,
    String? eventCreator,
    DateTime? eventCreationDate,
    String? lastEditedBy,
    DateTime? lastEditedOn,
    bool? isCompleted,
  }) : super(
          id: id,
          parentId: parentId,
          title: title,
          fromDate: fromDate,
          toDate: toDate,
          isAllDay: isAllDay,
          eventType: eventType,
          observations: observations,
          eventCreator: eventCreator,
          eventCreationDate: eventCreationDate,
          lastEditedBy: lastEditedBy,
          lastEditedOn: lastEditedOn,
          isCompleted: isCompleted,
        );

  TodoEvent.fromCulturalEvent(CulturalEvent e)
      : requester = e.requester,
        assignedEmployee = e.assignedEmployee,
        employees = e.employees,
        description = e.observations,
        super(
          id: e.id,
          parentId: e.parentId,
          title: e.title,
          fromDate: e.fromDate,
          toDate: e.toDate,
          eventType: e.eventType,
          observations: e.observations,
          eventCreator: e.eventCreator,
          eventCreationDate: e.eventCreationDate,
          lastEditedBy: e.lastEditedBy,
          lastEditedOn: e.lastEditedOn,
          isCompleted: e.isCompleted,
        );

  TodoEvent.fromSnapshot(DocumentSnapshot doc)
      : description = doc['description'],
        requester = doc['requester'],
        assignedEmployee =
            doc['assignedEmployee'] == null || doc['assignedEmployee'].isEmpty
                ? null
                : Employee.fromJson(doc['assignedEmployee']),
        employees = (doc['employees'] as List)
            .map((e) => Employee.fromJson(e))
            .toList(),
        super.fromSnapshot(doc);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['description'] = description ?? '';
    data['requester'] = requester ?? '';
    data['assignedEmployee'] = assignedEmployee?.toJson() ?? '';
    data['employees'] = employees?.map((e) => e.toJson()).toList() ?? [];
    return data;
  }

  @override
  TodoEvent copyWith(
      {String? type,
      int? numberOfPeople,
      List<Employee>? employees,
      Employee? assignedEmployee,
      String? attachmentsPath,
      String? requester,
      String? id,
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
    return TodoEvent(
      employees: employees ?? this.employees,
      assignedEmployee: assignedEmployee ?? this.assignedEmployee,
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
}
