import 'package:ccv_manager/common/provider/events_provider.dart';
import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/devil_costumes/providers/costume_requisition_provider.dart';
import 'package:ccv_manager/library_widget/providers/book_provider.dart';
import 'package:ccv_manager/models/library_models/hostel_page/providers/hostel_data_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/shift_provider.dart';
import 'package:ccv_manager/todo_widget/provider/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/dummy_notification _data.dart';
import '../../models/notifications/change_notification.dart';

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<InfoNotification>>((ref) {
  return NotificationNotifier(ref);
});

class NotificationNotifier extends StateNotifier<List<InfoNotification>> {
  NotificationNotifier(this.ref) : super([]) {
    fetchData();
  }

  final Ref ref;

  // final ProviderContainer ref;
  bool _isMounted = true; // Add a flag to track the mounted state

  // Override the `dispose` method to update the mounted state
  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> fetchData() async {
    // Check if the widget is still mounted before proceeding
    if (!_isMounted) return;

    List<InfoNotification> temp = [];

    temp.addAll(DummyNotificationData.suggestions); //!remove this

    // // Events for the next 5 days
    final events = ref.read(eventsProvider).where((event) =>
        event.fromDate
            .isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        event.fromDate.isBefore(DateTime.now().add(const Duration(days: 5))));
    if (events.isNotEmpty || events != null) {
      for (var e in events) {
        temp.add(InfoNotification(
          id: e.id!,
          title: e.title!,
          date: e.fromDate,
          eventType: e.eventType ?? EventType.activity,
          employees: e.employees,
          description: e.observations,
        ));
      }
    }

    // shifts for the next 5 days
    final shifts = ref.read(shiftProvider).where((shift) =>
        shift.fromDate
            .isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        shift.fromDate.isBefore(DateTime.now().add(const Duration(days: 5))));
    if (shifts.isNotEmpty || shifts != null) {
      for (var s in shifts) {
        temp.add(InfoNotification(
          id: s.id ?? "",
          title: s.assignedEmployee!.name ?? "Não definido",
          date: s.fromDate,
          eventType: s.eventType!,
          employees: s.employees,
          description: s.observations,
        ));
      }
    }

    // books to be returned in the next 5 days
    final books = ref.read(bookProvider).where((book) =>
        book.deliveryDateLimit
            .isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        book.deliveryDateLimit
            .isBefore(DateTime.now().add(const Duration(days: 5))));
    if (books.isNotEmpty || books != null) {
      for (var b in books) {
        temp.add(InfoNotification(
          id: b.id!,
          title: b.userName,
          date: b.deliveryDate!,
          eventType: b.eventType,
          description:
              "Devolução de livro(s): ${b.books.map((n) => n.title).join(", ")}",
          status: b.status,
        ));
      }
    }

    // devilCostumes for the next 5 days
    await ref.read(devilCostumeRequisitionProvider.notifier).getCostumes();
    var devilCostumes = ref.read(devilCostumeRequisitionProvider).where(
        (devilCostume) =>
            devilCostume.deliveryDateLimit!
                .isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
            devilCostume.deliveryDateLimit!
                .isBefore(DateTime.now().add(const Duration(days: 5))));
    if (devilCostumes.isNotEmpty || devilCostumes != null) {
      for (var d in devilCostumes) {
        temp.add(InfoNotification(
          id: d.id!,
          title: d.name,
          date: d.deliveryDate!,
          eventType: d.eventType,
          description:
              "Devolução de fatos de diabo: ${d.costumes.map((c) => c.size).join(", ")}",
          status: d.status,
        ));
      }
    }

    // hostelReservation for the next 5 days
    await ref.read(hostelProvider.notifier).getData();
    var reservations = ref.read(hostelProvider).where((reservation) =>
        reservation.fromDate
            .isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        reservation.fromDate
            .isBefore(DateTime.now().add(const Duration(days: 5))));
    if (reservations.isNotEmpty || reservations != null) {
      for (var r in reservations) {
        temp.add(InfoNotification(
          id: r.id!,
          title: r.title!,
          date: r.fromDate,
          eventType: r.eventType!,
          description: r.observations,
        ));
      }
    }

    // tasks for the next 5 days
    await ref.read(todoProvider.notifier).getTodoList();
    var todos = ref.read(todoProvider).where((todo) =>
        todo.fromDate
            .isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        todo.fromDate.isBefore(DateTime.now().add(const Duration(days: 5))));
    if (todos.isNotEmpty || todos != null) {
      for (var t in todos) {
        temp.add(InfoNotification(
          id: t.id!,
          title: t.title!,
          date: t.fromDate,
          employees: t.employees ?? [t.assignedEmployee!],
          eventType: t.eventType!,
          description: t.observations,
        ));
      }
    }

    // Only update the state if the widget is still mounted
    if (_isMounted) {
      state = temp;
    }
  }

  void remove(InfoNotification suggestion) {
    state = [
      for (final ev in state)
        if (ev != suggestion) ev
    ];
  }
}
