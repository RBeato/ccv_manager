import 'package:ccv_manager/models/cultural_events/cultural_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/personal_work_register/personal_work_register.dart';
import '../../services/firebase_storing.dart';

final shiftProvider =
    StateNotifierProvider<ShiftNotifier, List<PersonalWorkRegisterEvent>>(
        (ref) {
  return ShiftNotifier();
});

class ShiftNotifier extends StateNotifier<List<PersonalWorkRegisterEvent>> {
  ShiftNotifier() : super([]) {
    getEvents();
  }

  getEvents() async {
    // final dummyShiftsData = DummyShiftData.shifts;

    FirestoreService firestoreService = FirestoreService();
    List<PersonalWorkRegisterEvent> savedEvents = [];
    await firestoreService.getAll(FirestoreCollection.shifts).then((value) {
      for (var document in value.docs) {
        savedEvents.add(PersonalWorkRegisterEvent.fromSnapshot(document));
      }
    });
    // var temp = [...dummyShiftsData, ...dummyOffDaysData, ...savedEvents];
    var temp = [...savedEvents];

    state = temp..sort((a, b) => a.fromDate.compareTo(b.fromDate));
    print(state);
  }

  Future<void> add(PersonalWorkRegisterEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    var doc =
        await firestoreService.add(event.toJson(), FirestoreCollection.shifts);
    event.id = doc.id;

    state = [...state, event];
  }

  Future<void> edit(PersonalWorkRegisterEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        event.id!, event.toJson(), FirestoreCollection.shifts);

    state = [
      for (final e in state)
        if (e == event) e else event,
    ];
  }

  Future<void> remove(PersonalWorkRegisterEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(event.id!, FirestoreCollection.shifts);

    state = [
      for (final ev in state)
        if (ev != event) ev
    ];
  }

  Future<void> removeAllAssociatedWith(CulturalEvent event) async {
    FirestoreService firestoreService = FirestoreService();

    List todoList = state.where((e) => e.parentId == e.id).toList();

    for (var event in todoList) {
      await firestoreService.delete(event.id!, FirestoreCollection.todo);
      await firestoreService.delete(
          event.id!, FirestoreCollection.shifts); //TODO: Check

      state = [
        for (final ev in state)
          if (ev != event) ev
      ];
    }
  }
}
