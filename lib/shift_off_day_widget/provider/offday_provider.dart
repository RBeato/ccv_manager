import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/personal_work_register/personal_work_register.dart';
import '../../services/firebase_storing.dart';

final offDayProvider =
    StateNotifierProvider<OffDayNotifier, List<PersonalWorkRegisterEvent>>(
        (ref) {
  return OffDayNotifier();
});

class OffDayNotifier extends StateNotifier<List<PersonalWorkRegisterEvent>> {
  OffDayNotifier() : super([]) {
    getEvents();
  }

  List<PersonalWorkRegisterEvent> getOffDaysForEmployee(String employeeId) {
    return state
        .where((event) => event.assignedEmployee!.authId == employeeId)
        .toList();
  }

  Future<void> getEvents() async {
    // final dummyOffDaysData = DummyOffDayData.offDays;
    FirestoreService firestoreService = FirestoreService();
    List<PersonalWorkRegisterEvent> savedEvents = [];
    try {
      await firestoreService.getAll(FirestoreCollection.offDays).then((value) {
        for (var document in value.docs) {
          savedEvents.add(PersonalWorkRegisterEvent.fromSnapshot(document));
        }
      });
    } catch (e) {
      print(e);
    }
    // var temp = [...dummyOffDaysData, ...savedEvents];
    var temp = [...savedEvents];
    state = temp..sort((a, b) => a.fromDate.compareTo(b.fromDate));
  }

  Future<void> add(PersonalWorkRegisterEvent newEvent) async {
    FirestoreService firestoreService = FirestoreService();
    var doc = await firestoreService.add(
        newEvent.toJson(), FirestoreCollection.offDays);
    newEvent.id = doc.id;

    state = [...state, newEvent];
  }

  Future<void> edit(PersonalWorkRegisterEvent newEvent) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        newEvent.id!, newEvent.toJson(), FirestoreCollection.offDays);
    state = [
      for (final event in state)
        if (newEvent == event) newEvent else event,
    ];
  }

  Future<void> remove(PersonalWorkRegisterEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(event.id!, FirestoreCollection.offDays);

    state = [
      for (final ev in state)
        if (ev != event) ev
    ];
  }
}
