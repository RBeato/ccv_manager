import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum EmployeeState { absent, available }

class EmployeeAppointment {
  DateTime fromDate;
  DateTime toDate;
  String employeeId;
  String type;
  String subType;
  EmployeeAppointment({
    required this.fromDate,
    required this.toDate,
    required this.employeeId,
    required this.type,
    required this.subType,
  });

  Map<String, dynamic> toMap() {
    return {
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
      'employeeId': employeeId,
      'type': type,
      'subType': subType,
    };
  }

  factory EmployeeAppointment.fromMap(Map<String, dynamic> map) {
    return EmployeeAppointment(
      fromDate: DateTime.fromMillisecondsSinceEpoch(map['fromDate']),
      toDate: DateTime.fromMillisecondsSinceEpoch(map['toDate']),
      employeeId: map['employeeId'] ?? '',
      type: map['type'] ?? '',
      subType: map['subType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeAppointment.fromJson(String source) =>
      EmployeeAppointment.fromMap(json.decode(source));
}

class Employee {
  String name;
  String authId;
  String email;
  int? phone;
  String role;
  EmployeeState? state;
  EmployeeAppointment? employeeAppointment;

  Employee({
    required this.name,
    required this.authId,
    required this.email,
    this.phone,
    required this.role,
    this.state,
    this.employeeAppointment,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'authId': authId,
      'email': email,
      'phone': phone,
      'role': role,
      'employeeAppointment': employeeAppointment?.toMap(),
      'state': state?.toString().split('.').last,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'] ?? '',
      authId: map['authId'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone']?.toInt() ?? 0,
      role: map['role'] ?? '',
      state: map['state'] != null
          ? EmployeeState.values.byName(map['state'])
          : null,
      employeeAppointment: map['employeeAppointment'] != null
          ? EmployeeAppointment.fromMap(map['employeeAppointment'])
          : null,
    );
  }

// The function that will be run in the isolate
  List<Map<String, dynamic>> _computeFormTasks(Map<String, dynamic> json) {
    // Convert the JSON back to an Employee object
    var employee = Employee.fromJson(json['employee']);

    // Placeholder for computation logic
    // Here you can perform any intensive tasks, like complex calculations,
    // processing large amounts of data, etc.

    // Example of a computed result, this is where you would include the actual logic
    List<Map<String, dynamic>> results = [];

    // Perform your computations with the employee object here
    // For example, we could check if the employee is available and add some result
    if (employee.state == EmployeeState.available) {
      // Do something with the available employee
      // And then add some result to the list
      results.add({
        'resultKey': 'Some result value or object converted to Map',
        // ... other key-value pairs as needed ...
      });
    }

    // Return the results as a list of maps which can be serialized back to the main isolate
    return results;
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  factory Employee.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Employee(
      authId: data['authId'],
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone']?.toInt() ?? 0,
      role: data['role'] ?? '',
      state: data['state'] != null
          ? EmployeeState.values.byName(data['state'])
          : null,
      employeeAppointment: data['employeeAppointment'] != null
          ? EmployeeAppointment.fromMap(data['employeeAppointment'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Employee(name: $name, authId: $authId, email: $email, phone: $phone, role: $role)';
  }
}
