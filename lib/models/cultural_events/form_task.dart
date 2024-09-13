import 'dart:convert';

import 'package:ccv_manager/models/employee.dart';

enum FormTaskProgress { selected, inProgress, completed }

class FormTask {
  String? id;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  Employee? assignedEmployee;
  bool isNeeded;
  String titleTranslation;
  FormTaskProgress? progress;

  FormTask({
    this.id,
    this.description,
    this.startDate,
    this.endDate,
    this.assignedEmployee,
    this.isNeeded = false,
    this.progress,
    required this.titleTranslation,
  });

  FormTask copyWith({
    String? id,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    bool? isNeeded,
    bool? isCompleted,
    FormTaskProgress? progress,
    String? titleTranslation,
  }) {
    return FormTask(
      id: id ?? this.id,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      assignedEmployee: assignedEmployee ?? this.assignedEmployee,
      isNeeded: isNeeded ?? this.isNeeded,
      titleTranslation: titleTranslation ?? this.titleTranslation,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'assignedEmployee': assignedEmployee?.toMap(),
      'isNeeded': isNeeded,
      'titleTranslation': titleTranslation,
      'progress': progress?.index,
    };
  }

  factory FormTask.fromMap(Map<String, dynamic> map) {
    return FormTask(
      description: map['description'],
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
          : null,
      assignedEmployee: map['assignedEmployee'] != null
          ? Employee.fromMap(map['assignedEmployee'])
          : null,
      isNeeded: map['isNeeded'],
      titleTranslation: map['titleTranslation'] ?? '',
      progress: map['progress'] != null
          ? FormTaskProgress.values[map['progress']]
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormTask.fromJson(String source) =>
      FormTask.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FormTask(description: $description, startDate: $startDate, endDate: $endDate, assignedEmployee: $assignedEmployee, titleTranslation: $titleTranslation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormTask &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.assignedEmployee == assignedEmployee &&
        other.isNeeded == isNeeded &&
        other.titleTranslation == titleTranslation &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        assignedEmployee.hashCode ^
        isNeeded.hashCode ^
        progress.hashCode ^
        titleTranslation.hashCode;
  }
}
