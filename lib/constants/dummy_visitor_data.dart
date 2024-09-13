import '../models/visitors/visitor_register_event.dart';

class DummyVisitorData {
  static List<VisitorRegisterEvent> visitors = [
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 20)),
      toDate: DateTime.now().subtract(const Duration(days: 20)),
      visitorCounter: 1,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 19)),
      toDate: DateTime.now().subtract(const Duration(days: 19)),
      visitorCounter: 1,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 18)),
      toDate: DateTime.now().subtract(const Duration(days: 18)),
      visitorCounter: 12,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 17)),
      toDate: DateTime.now().subtract(const Duration(days: 17)),
      visitorCounter: 15,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 16)),
      toDate: DateTime.now().subtract(const Duration(days: 16)),
      visitorCounter: 13,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 15)),
      toDate: DateTime.now().subtract(const Duration(days: 15)),
      visitorCounter: 3,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 13)),
      toDate: DateTime.now().subtract(const Duration(days: 13)),
      visitorCounter: 6,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 12)),
      toDate: DateTime.now().subtract(const Duration(days: 12)),
      visitorCounter: 25,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 11)),
      toDate: DateTime.now().subtract(const Duration(days: 11)),
      visitorCounter: 8,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 9)),
      toDate: DateTime.now().subtract(const Duration(days: 9)),
      visitorCounter: 15,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 8)),
      toDate: DateTime.now().subtract(const Duration(days: 8)),
      visitorCounter: 12,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 7)),
      toDate: DateTime.now().subtract(const Duration(days: 7)),
      visitorCounter: 10,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 6)),
      toDate: DateTime.now().subtract(const Duration(days: 6)),
      visitorCounter: 3,
    ),
    VisitorRegisterEvent(
      fromDate: DateTime.now().subtract(const Duration(days: 4)),
      toDate: DateTime.now().subtract(const Duration(days: 4)),
      visitorCounter: 7,
    ),
  ];
}
