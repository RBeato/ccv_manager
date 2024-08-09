import 'package:ccv_manager/events_widget/provider/event_provider.dart';
import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:ccv_manager/models/layout_helper_models/filter_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../home_page/provider/filters_provider.dart';

StateProvider<List<CalendarEvent>> filteredEventsProvider =
    StateProvider((ref) {
  FilterManager filter = ref.watch(filtersProvider);
  var result = <CalendarEvent>[];

  if (filter.eventType!.selectedItem != "Todos") {
    result = ref.watch(eventsProvider).where((e) {
      var a = Constants.eventTypeToString[e.eventType];
      var b = filter.eventType!.selectedItem;
      print("a: $a, b: $b");
      return a == b;
    }).toList();
  } else {
    result = ref.watch(eventsProvider);
  }
  return result;
});
