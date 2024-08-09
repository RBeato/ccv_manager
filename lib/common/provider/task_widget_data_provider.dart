import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/models/library_models/hostel_page/providers/hostel_data_provider.dart';
import 'package:ccv_manager/models/calendar_event/calendar_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../events_widget/provider/event_provider.dart';
import '../../home_page/provider/tile_selection_provider.dart';
import '../../shift_off_day_widget/provider/shift_and_absence_data_provider.dart';

StateProvider<List<CalendarEvent>> todoDataProvider = StateProvider((ref) {
  final page = ref.watch(pageSelectionProvider);
  switch (page) {
    case PageSelection.events:
      return ref.watch(eventsProvider);

    case PageSelection.shiftsAndOffDays:
      return ref.watch(shiftAndAbsenceDataProvider);

    case PageSelection.hostel:
      return ref.watch(hostelProvider);
    default:
      return [];
  }
});
