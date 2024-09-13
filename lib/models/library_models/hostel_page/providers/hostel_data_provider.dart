import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/dummy_hostel_data.dart';
import '../../../../services/firebase_storing.dart';
import '../../../hostel_register/hostel_register.dart';

final hostelProvider =
    StateNotifierProvider<HostelDataNotifier, List<HostelRegisterEvent>>((ref) {
  return HostelDataNotifier();
});

class HostelDataNotifier extends StateNotifier<List<HostelRegisterEvent>> {
  HostelDataNotifier() : super([]) {
    getData();
  }

  Future<void> getData() async {
    List<HostelRegisterEvent> reservations = [];
    FirestoreService firestoreService = FirestoreService();
    await firestoreService
        .getAll(FirestoreCollection.hostelReservations)
        .then((value) {
      for (var document in value.docs) {
        reservations.add(HostelRegisterEvent.fromSnapshot(document));
      }
    });

    state = [
      ...DummyReservationData.reservations,
      ...reservations
    ]; //!remove this
    // state = [...reservations];

    print(state);
  }

  Future<void> add(HostelRegisterEvent newRequisition) async {
    FirestoreService firestoreService = FirestoreService();
    var doc = await firestoreService.add(
        newRequisition.toJson(), FirestoreCollection.hostelReservations);
    newRequisition.id = doc.id;
    state = [...state, newRequisition];
    print(state);
  }

  Future<void> edit(HostelRegisterEvent res) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        res.id!, res.toJson(), FirestoreCollection.hostelReservations);
    state = [
      for (final reservation in state)
        if (res.id == reservation.id) res else reservation,
    ];
    print(state);
  }

  Future<void> remove(HostelRegisterEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(
        event.id!, FirestoreCollection.hostelReservations);
    state = [
      for (final ev in state)
        if (ev.id != event.id) ev
    ];
    print(state);
  }
}
