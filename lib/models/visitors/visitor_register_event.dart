import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ccv_manager/models/calendar_event/calendar_event.dart';

import '../../constants/constants.dart';

class VisitorRegisterEvent extends CalendarEvent {
  final int visitorCounter;
  final String type;

  VisitorRegisterEvent({
    this.type = Constants.visitorsRegister,
    required this.visitorCounter,
    String? id,
    String? parentId,
    String? title,
    required DateTime fromDate,
    required DateTime toDate,
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

  VisitorRegisterEvent.fromSnapshot(DocumentSnapshot doc)
      : type = doc['type'],
        visitorCounter = doc['visitorCounter'],
        super.fromSnapshot(doc);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['type'] = type;
    data['visitorCounter'] = visitorCounter;
    return data;
  }

  @override
  VisitorRegisterEvent copyWith(
      {String? type,
      int? visitorCounter,
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
    return VisitorRegisterEvent(
      type: type ?? this.type,
      visitorCounter: visitorCounter ?? this.visitorCounter,
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
  String toString() =>
      'VisitorRegisterEvent(visitorCounter: $visitorCounter, type: $type)';
}
