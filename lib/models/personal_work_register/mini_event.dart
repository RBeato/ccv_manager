import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_offday_editing_page/form_switch.dart';

class MiniEvent {
  String? id;
  DateTime? from;
  DateTime? to;
  List<Employee>? employees;
  String? observations;
  String type;
  Colors? backgroundColor;
  SelectedCategory category;
  MiniEvent({
    this.from,
    this.to,
    this.employees,
    this.observations,
    required this.category,
    required this.type,
    this.backgroundColor,
  }) {
    id = const Uuid().v4();
  }

  MiniEvent copyWith({
    DateTime? from,
    DateTime? to,
    List<Employee>? employees,
    String? observations,
    String? shiftType,
    SelectedCategory? category,
  }) {
    return MiniEvent(
      from: from ?? this.from,
      to: to ?? this.to,
      employees: employees ?? this.employees,
      observations: observations ?? this.observations,
      type: shiftType ?? type,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'MiniEvent(id: $id, from: $from, to: $to, employees: $employees, observations: $observations, type: $type, backgroundColor: $backgroundColor, category: $category)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from': from?.millisecondsSinceEpoch,
      'to': to?.millisecondsSinceEpoch,
      'employees': employees?.map((x) => x.toMap()).toList(),
      'observations': observations,
      'type': type,
      'backgroundColor': backgroundColor,
      'category': category,
    };
  }

  factory MiniEvent.fromMap(Map<String, dynamic> map) {
    return MiniEvent(
      // id: map['id'],
      from: map['from'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['from'])
          : null,
      to: map['to'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['to'])
          : null,
      employees: map['employees'] != null
          ? List<Employee>.from(
              map['employees']?.map((x) => Employee.fromMap(x)))
          : null,
      observations: map['observations'],
      type: map['type'] ?? '',
      backgroundColor: map['backgroundColor'],
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniEvent.fromJson(String source) =>
      MiniEvent.fromMap(json.decode(source));
}
