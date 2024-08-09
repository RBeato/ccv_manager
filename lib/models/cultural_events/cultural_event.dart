import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/models/calendar_event/calendar_event.dart';

import '../employee.dart';
import 'auditorium.dart';
import 'form_task.dart';

class CulturalEvent extends CalendarEvent {
  String? type;
  int? numberOfPeople;
  List<Employee>? employees;
  Employee? assignedEmployee;
  String? room;
  String? equipment;
  String? evaluation;
  Auditorium? auditorium;
  String? attachmentsPath;
  String? requester;
  double? price;
  List<FormTask>? formTasks;

  CulturalEvent({
    this.type,
    this.numberOfPeople,
    this.room,
    this.evaluation,
    this.attachmentsPath,
    this.employees,
    this.requester,
    this.assignedEmployee,
    this.equipment,
    this.auditorium,
    this.price,
    this.formTasks,
    required DateTime fromDate,
    required DateTime toDate,
    String? id,
    String? parentId,
    String? title,
    bool isAllDay = false,
    EventType? eventType,
    String? recurrenceRule,
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

  CulturalEvent.fromSnapshot(DocumentSnapshot doc)
      : type = doc['type'],
        requester = doc['requester'],
        price = doc['price'],
        assignedEmployee =
            doc['assignedEmployee'] == null || doc['assignedEmployee'].isEmpty
                ? null
                : Employee.fromJson(doc['assignedEmployee']),
        employees = (doc['employees'] as List)
            .map((e) => Employee.fromJson(e))
            .toList(),
        auditorium = doc['auditorium'] == null || doc['auditorium'].isEmpty
            ? null
            : Auditorium.fromJson(doc['auditorium']),
        formTasks = (doc['formTasks'] as List<FormTask>),
        super.fromSnapshot(doc);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['type'] = type;
    data['assignedEmployee'] = assignedEmployee?.toJson() ?? '';
    data['requester'] = requester ?? '';
    data['employees'] = employees?.map((e) => e.toJson()).toList() ?? [];
    data['auditorium'] = auditorium?.toJson() ?? '';
    data['price'] = price ?? 0.0;
    data['formTasks'] = formTasks?.map((e) => e.toJson()).toList() ?? [];
    return data;
  }

  @override
  CulturalEvent copyWith(
      {String? type,
      int? numberOfPeople,
      List<Employee>? employees,
      Employee? assignedEmployee,
      double? price,
      String? room,
      String? equipment,
      String? evaluation,
      Auditorium? auditorium,
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
      List<FormTask>? formTasks,
      bool? isCompleted}) {
    return CulturalEvent(
      price: price ?? this.price,
      type: type ?? this.type,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      employees: employees ?? this.employees,
      assignedEmployee: assignedEmployee ?? this.assignedEmployee,
      room: room ?? this.room,
      equipment: equipment ?? this.equipment,
      evaluation: evaluation ?? this.evaluation,
      auditorium: auditorium ?? this.auditorium,
      attachmentsPath: attachmentsPath ?? this.attachmentsPath,
      requester: requester ?? this.requester,
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
      formTasks: formTasks ?? this.formTasks,
    );
  }

  @override
  String toString() {
    return 'CulturalEvent(type: $type, numberOfPeople: $numberOfPeople, employees: $employees, assignedEmployee: $assignedEmployee, room: $room, equipment: $equipment, evaluation: $evaluation, auditorium: $auditorium, attachmentsPath: $attachmentsPath, requester: $requester, price: $price, formTasks: $formTasks)';
  }
}
