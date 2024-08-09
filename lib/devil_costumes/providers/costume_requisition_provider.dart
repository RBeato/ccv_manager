import 'package:ccv_manager/models/devil_costumes/devil_costume_request.dart';
import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final devilCostumeRequisitionProvider = StateNotifierProvider<
    CostumeRequisitionNotifier, List<DevilCostumeRequest>>((ref) {
  return CostumeRequisitionNotifier();
});

class CostumeRequisitionNotifier
    extends StateNotifier<List<DevilCostumeRequest>> {
  CostumeRequisitionNotifier() : super([]) {
    getCostumes();
  }

  getCostumes() async {
    // final dummyData = DummyDevilCostumeData.reqCostumes;
    List<DevilCostumeRequest> savedRequests = [];
    FirestoreService firestoreService = FirestoreService();
    await firestoreService
        .getAll(FirestoreCollection.devilCostumes)
        .then((value) {
      for (var document in value.docs) {
        savedRequests.add(DevilCostumeRequest.fromSnapshot(document));
      }
    });
    // state = [...dummyData, ...savedRequests];
    state = [...savedRequests];

    print(state);
  }

  void add(DevilCostumeRequest newRequisition) async {
    FirestoreService firestoreService = FirestoreService();
    var doc = await firestoreService.add(
        newRequisition.toMap(), FirestoreCollection.devilCostumes);
    state = [...state, newRequisition.copyWith(id: doc.id)];
    print(state);
  }

  void edit(DevilCostumeRequest req) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        req.id!, req.toMap(), FirestoreCollection.devilCostumes);
    state = [
      for (final event in state)
        if (req == event) req else event,
    ];
    print(state);
  }

  void remove(DevilCostumeRequest costumeReq) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(
        costumeReq.id!, FirestoreCollection.devilCostumes);
    state = [
      for (final ev in state)
        if (ev != costumeReq) ev
    ];
    print(state);
  }
}
