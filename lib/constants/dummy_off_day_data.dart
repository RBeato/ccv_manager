import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/constants/dummy_employee_list.dart';

import '../models/personal_work_register/personal_work_register.dart';

class DummyOffDayData {
  static List<PersonalWorkRegisterEvent> offDays = [
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[0],
      eventType: EventType.offDay,
      fromDate: DateTime.now().subtract(const Duration(days: 4)),
      toDate: DateTime.now().subtract(const Duration(days: 3)),
      type: Constants.weekend,
    ),
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[1],
      eventType: EventType.offDay,
      fromDate: DateTime.now().subtract(const Duration(days: 6)),
      toDate: DateTime.now().subtract(const Duration(days: 5)),
      type: Constants.hours,
    ),
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[2],
      eventType: EventType.offDay,
      fromDate: DateTime.now().subtract(const Duration(days: 1)),
      toDate: DateTime.now(),
      type: Constants.holiday,
    ),
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[3],
      eventType: EventType.offDay,
      fromDate: DateTime.now().add(const Duration(days: 7)),
      toDate: DateTime.now().add(const Duration(days: 8)),
      type: Constants.weekend,
    ),
    PersonalWorkRegisterEvent(
      assignedEmployee: DummyEmployeeData.employees[4],
      eventType: EventType.offDay,
      fromDate: DateTime.now().subtract(const Duration(hours: 3)),
      toDate: DateTime.now().add(const Duration(minutes: 15)),
      type: Constants.weekend,
    ),
  ];
}
