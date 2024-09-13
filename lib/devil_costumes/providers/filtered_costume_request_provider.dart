import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/devil_costumes/providers/costume_requisition_provider.dart';
import 'package:ccv_manager/home_page/provider/filters_provider.dart';
import 'package:ccv_manager/models/devil_costumes/devil_costume_request.dart';
import 'package:ccv_manager/models/library_models/book_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/dummy_devil_costumes_data.dart';

StateProvider<List<DevilCostumeRequest>> filteredCostumeRequestProvider =
    StateProvider((ref) {
  final filters = ref.watch(filtersProvider);
  var result = <DevilCostumeRequest>[];
  if (filters.devilCostumes!.selectedItem == Constants.requestOptions[1]) {
    result = ref
        .watch(devilCostumeRequisitionProvider)
        .where((req) => req.status == RequisitionStatus.toBeDelivered)
        .toList();
  } else {
    result = ref.watch(devilCostumeRequisitionProvider);
  }

  result.addAll(DummyDevilCostumeData.reqCostumes); //!remove this

  return result;
});
