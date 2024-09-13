import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class HostelRegisterEvent extends CalendarEvent {
  final String? type;

  HostelRegisterEvent({
    this.type = Constants.hostelReservation,
    required DateTime fromDate,
    required DateTime toDate,
    bool isAllDay = false,
    String? eventName,
    String? id,
    String? parentId,
    EventType? eventType,
    String? observations,
    String? eventCreator,
    DateTime? eventCreationDate,
    String? lastEditedBy,
    DateTime? lastEditedOn,
    bool? isCompleted,
  }) : super(
          fromDate: fromDate,
          toDate: toDate,
        );

  HostelRegisterEvent.fromSnapshot(DocumentSnapshot doc)
      : type = doc['type'],
        super.fromSnapshot(doc);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['type'] = type;

    return data;
  }

  @override
  HostelRegisterEvent copyWith(
      {String? type,
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
    return HostelRegisterEvent(
      type: type ?? this.type,
      eventName: eventName ?? title,
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      fromDate: from ?? fromDate,
      toDate: to ?? toDate,
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
