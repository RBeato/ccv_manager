import 'package:flutter/material.dart';

class OffDay {
  DateTime from;
  DateTime to;
  List<String>? employees;
  String? observations;
  String shiftType;
  Colors? backgroundColor;
  OffDay({
    required this.from,
    required this.to,
    this.employees,
    this.observations,
    required this.shiftType,
    this.backgroundColor,
  });

  OffDay copyWith({
    DateTime? from,
    DateTime? to,
    List<String>? employees,
    String? observations,
    String? shiftType,
  }) {
    return OffDay(
      from: from ?? this.from,
      to: to ?? this.to,
      employees: employees ?? this.employees,
      observations: observations ?? this.observations,
      shiftType: shiftType ?? this.shiftType,
    );
  }
}
