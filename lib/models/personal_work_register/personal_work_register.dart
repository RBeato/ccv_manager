import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:ccv_manager/models/personal_work_register/mini_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonalWorkRegisterEvent extends CalendarEvent {
  final String? type;
  final String? subType;
  final String? duration;
  final double? countPercentage;
  List<MiniEvent>? miniEvents = [];
  Employee? assignedEmployee;
  List<Employee>? employees;

  PersonalWorkRegisterEvent({
    this.type,
    this.subType,
    this.duration,
    this.countPercentage,
    this.assignedEmployee,
    this.employees,
    this.miniEvents,
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

  PersonalWorkRegisterEvent.fromSnapshot(DocumentSnapshot doc)
      : type = doc['type'],
        subType = doc['subType'],
        duration = doc['duration'],
        countPercentage = doc['countPercentage'],
        assignedEmployee =
            doc['assignedEmployee'] == null || doc['assignedEmployee'].isEmpty
                ? null
                : Employee.fromJson(doc['assignedEmployee']),
        employees = (doc['employees'] as List)
            .map((e) => Employee.fromJson(e))
            .toList(),
        miniEvents = [], //!FIX THIS
        //     (doc['miniEvents'] as List<MiniEvent>)
        // .map((e) => MiniEvent.fromJson(e))
        // .toList(),
        super.fromSnapshot(doc);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['type'] = type;
    data['subType'] = subType;
    data['duration'] = duration;
    data['countPercentage'] = countPercentage;
    data['assignedEmployee'] = assignedEmployee?.toJson() ?? '';
    data['employees'] = employees?.map((e) => e.toJson()).toList() ?? [];
    data['miniEvents'] = miniEvents?.map((e) => e.toJson()).toList() ?? [];
    return data;
  }

  @override
  PersonalWorkRegisterEvent copyWith(
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
    return PersonalWorkRegisterEvent(
      type: type ?? this.type,
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
