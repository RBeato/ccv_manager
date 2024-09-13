import 'package:ccv_manager/constants/constants.dart';

import '../models/cultural_events/cultural_event.dart';
import '../models/employee.dart';

class DummyEventsData {
  static final DateTime today = DateTime.now();

  static List<CulturalEvent> getDataSource() {
    final List<CulturalEvent> events = <CulturalEvent>[];

    events.add(CulturalEvent(
      id: "123",
      title: 'Conferência',
      fromDate: DateTime(today.year, today.month, today.day, 9),
      toDate: DateTime(today.year, today.month, today.day, 9)
          .add(const Duration(hours: 2)),
      eventType: EventType.meeting,
      numberOfPeople: 10,
      room: Constants.dinningRoom,
      equipment: 'Projetor',
      observations: 'None',
      evaluation: 'Good',
      employees: [
        Employee(
            name: 'Bruno', email: "a", authId: "1", phone: 123, role: "Editor")
      ],
      eventCreator: 'Bruno',
    ));

    final t = today.add(const Duration(days: 2));
    events.add(CulturalEvent(
      id: "123",
      title: 'Dança',
      fromDate: DateTime(t.year, t.month, t.day, 9),
      toDate: DateTime(t.year, t.month, t.day, 9).add(const Duration(hours: 2)),
      eventType: EventType.dance,
      numberOfPeople: 100,
      room: Constants.mainAuditorium,
      equipment: 'Sound System',
      observations: 'None',
      evaluation: 'Good',
      employees: [
        Employee(
            name: 'Bruno', email: "a", authId: "1", phone: 123, role: "Editor"),
        Employee(
            name: 'Romeu', email: "a", authId: "1", phone: 123, role: "Admin")
      ],
      eventCreator: 'Tiago',
    ));

    events.add(CulturalEvent(
      id: "123",
      title: 'Reserva de sala',
      fromDate: DateTime(t.year, t.month, t.day, 9)
          .subtract(const Duration(hours: 4)),
      toDate: DateTime(t.year, t.month, t.day, 9).add(const Duration(hours: 4)),
      eventType: EventType.roomReservation,
      numberOfPeople: 10,
      room: Constants.dinningRoom,
      equipment: 'Projector',
      observations: 'None',
      evaluation: 'Good',
      employees: [
        Employee(
          name: 'Cristina',
          email: "a",
          authId: "1",
          phone: 123,
          role: "Reader",
        )
      ],
      eventCreator: 'Tiago',
    ));

    return events;
  }
}
