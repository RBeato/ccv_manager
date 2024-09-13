import 'package:ccv_manager/models/layout_helper_models/filter_manager.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/offday_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/shift_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/dummy_shift_data.dart';
import '../../home_page/provider/filters_provider.dart';
import '../../models/personal_work_register/personal_work_register.dart';

StateProvider<List<PersonalWorkRegisterEvent>> filteredWorkDataProvider =
    StateProvider((ref) {
  FilterManager filter = ref.watch(filtersProvider);
  var result = <PersonalWorkRegisterEvent>[];

  if (filter.employeeActivityOption!.selectedItem == "Todas") {
    var shifts = ref.watch(shiftProvider);
    var offDays = ref.watch(offDayProvider);

    if (filter.employee!.selectedItem == "Todos") {
      result = [...shifts, ...offDays];
    } else {
      result = [...shifts, ...offDays]
          .where(
              (e) => e.assignedEmployee!.name == filter.employee!.selectedItem)
          .toList();
    }
  } else if (filter.employeeActivityOption!.selectedItem == "Turnos") {
    result = ref.watch(shiftProvider);
    if (filter.employee!.selectedItem == "Todos") {
      return result;
    } else {
      result = result
          .where(
              (e) => e.assignedEmployee!.name == filter.employee!.selectedItem)
          .toList();
    }
    return result;
  } else if (filter.employeeActivityOption!.selectedItem == "Folgas") {
    result = ref.watch(offDayProvider);
    if (filter.employee!.selectedItem == "Todos") {
      return result;
    } else {
      result = result
          .where(
              (e) => e.assignedEmployee!.name == filter.employee!.selectedItem)
          .toList();
    }
    return result;
  }
  result.addAll(DummyShiftData.shifts); //!remove this

  return result;
});
