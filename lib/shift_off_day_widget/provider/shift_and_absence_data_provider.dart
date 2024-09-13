import 'package:ccv_manager/shift_off_day_widget/provider/offday_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/shift_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/calendar_event/calendar_event.dart';

final shiftAndAbsenceDataProvider = StateProvider<List<CalendarEvent>>((ref) {
  final shifts = ref.watch(shiftProvider);
  final absences = ref.watch(offDayProvider);

  return [...shifts, ...absences];
});
