import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/devil_costumes/devil_costume.dart';

final devilCostumeListProvider =
    StateNotifierProvider<CostumeRequisitionNotifier, List<DevilCostume>>(
        (ref) {
  return CostumeRequisitionNotifier();
});

class CostumeRequisitionNotifier extends StateNotifier<List<DevilCostume>> {
  CostumeRequisitionNotifier() : super([]) {
    getCostumes();
  }

  List<DevilCostume> get allCostumesRequest => state;

  getCostumes() async {
    // final dummyData = DummyDevilCostumeData.reqCostumes;
    // List<DevilCostumeRequest> savedRequests = [];

    // state = [...dummyData, ...savedRequests];
  }

  void add(DevilCostume costumes) async {
    state = [...state, costumes];
    print(state);
  }

  void update(DevilCostume costumeData) async {
    state = [
      for (final c in state)
        if (costumeData.id == c.id) costumeData else c,
    ];
    print(state);
  }

  void remove(DevilCostume costumeData) async {
    state = [
      for (final ev in state)
        if (ev != costumeData) ev
    ];
    print(state);
  }
}
