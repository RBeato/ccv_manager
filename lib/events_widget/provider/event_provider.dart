import 'package:ccv_manager/models/cultural_events/cultural_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/dummy_calendar_data.dart';
import '../../services/firebase_storing.dart';

final eventsProvider =
    StateNotifierProvider<EventNotifier, List<CulturalEvent>>((ref) {
  return EventNotifier();
});

class EventNotifier extends StateNotifier<List<CulturalEvent>> {
  EventNotifier() : super([]) {
    getEvents();
  }

  getEvents() async {
    final dummyData = DummyEventsData.getDataSource();
    FirestoreService firestoreService = FirestoreService();
    List<CulturalEvent> savedEvents = [];
    await firestoreService.getAll(FirestoreCollection.events).then((value) {
      for (var document in value.docs) {
        savedEvents.add(CulturalEvent.fromSnapshot(document));
      }
    });
    var temp = [...dummyData, ...savedEvents];
    // var temp = [...savedEvents];

    state = temp..sort((a, b) => a.fromDate.compareTo(b.fromDate));
    print(state);
  }

  Future<void> add(CulturalEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    var doc =
        await firestoreService.add(event.toJson(), FirestoreCollection.events);
    state = [...state, event.copyWith(id: doc.id)];
  }

  Future<void> edit(CulturalEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        event.id!, event.toJson(), FirestoreCollection.events);

    state = [
      for (final e in state)
        if (event.id == e.id) event else e,
    ];
  }

  Future<void> remove(CulturalEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(event.id!, FirestoreCollection.events);
    state = [
      for (final ev in state)
        if (ev != event) ev
    ];
  }
}
