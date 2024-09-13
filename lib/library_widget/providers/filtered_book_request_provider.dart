import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/home_page/provider/filters_provider.dart';
import 'package:ccv_manager/library_widget/providers/book_provider.dart';
import 'package:ccv_manager/models/library_models/book_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/dummy_library_data.dart';

StateProvider<List<BookRequest>> filteredBookRequestProvider =
    StateProvider((ref) {
  final filters = ref.watch(filtersProvider);

  var result = <BookRequest>[];

  if (filters.library!.selectedItem == Constants.requestOptions[1]) {
    result = ref
        .watch(bookProvider)
        .where((req) => req.status == RequisitionStatus.toBeDelivered)
        .toList();
  }
  if (filters.library!.selectedItem == Constants.requestOptions[0]) {
    result = ref.watch(bookProvider);
  }

  result.addAll(DummyLibraryData.reqBooks); //!remove this
  return result;
});
