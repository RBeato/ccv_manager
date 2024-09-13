import 'package:ccv_manager/constants/constants.dart';

import '../models/personal_work_register/personal_work_register.dart';
import 'dummy_employee_list.dart';

class DummyShiftData {
  static List<PersonalWorkRegisterEvent> shifts = [
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[1],
      eventType: EventType.shift,
      fromDate: DateTime.now().subtract(const Duration(days: 5)),
      toDate: DateTime.now().subtract(const Duration(days: 4)),
      type: Constants.weekend,
      observations: "Troca",
    ),
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[4],
      eventType: EventType.shift,
      fromDate: DateTime.now().subtract(const Duration(days: 3)),
      toDate: DateTime.now().subtract(const Duration(days: 2)),
      type: Constants.hours,
      observations: "Troca",
    ),
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[3],
      eventType: EventType.shift,
      fromDate: DateTime.now().subtract(const Duration(hours: 2)),
      toDate: DateTime.now().add(const Duration(minutes: 20)),
      type: Constants.holiday,
      observations: "Troca",
    ),
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[2],
      eventType: EventType.shift,
      fromDate: DateTime.now().add(const Duration(days: 5)),
      toDate: DateTime.now().add(const Duration(days: 6)),
      type: Constants.weekend,
      observations: "Troca",
    ),
  ];
}
