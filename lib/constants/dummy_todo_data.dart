import '../models/calendar_event/calendar_event.dart';

class DummyTodoData {
  static List<CalendarEvent> todoList = [
    CalendarEvent(
      title: 'Organizar sala para reunião',
      // requester: 'João Silva',
      fromDate: DateTime.now(),
      toDate: DateTime.now().add(const Duration(hours: 2)),
      // assignedEmployee: DummyEmployeeData.employees[0],
      eventCreationDate: DateTime.now(),
      // employees: [
      //   DummyEmployeeData.employees[1],
      //   DummyEmployeeData.employees[2],
      // ],
      eventCreator: "Bruno",
      observations: "Deixar a sala pronta para a reunião antes das X",
    ),
    CalendarEvent(
      title: 'Filme',
      // requester: 'João Silva',
      fromDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
      toDate: DateTime.now().add(const Duration(days: 1, hours: 3)),
      // assignedEmployee: DummyEmployeeData.employees[0],
      // employees: [
      //   DummyEmployeeData.employees[2],
      //   DummyEmployeeData.employees[3],
      // ],
      eventCreationDate: DateTime.now(),
      eventCreator: "Bruno",
      observations: "Deixar a sala pronta para a filme antes das X",
    ),
  ];
}
