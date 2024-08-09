// In event_editing_logic.dart
import 'package:ccv_manager/events_widget/provider/mini_event_provider.dart';
import 'package:ccv_manager/home_page/provider/user_provider.dart';
import 'package:ccv_manager/models/personal_work_register/mini_event.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/offday_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/shift_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_offday_editing_page/form_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../models/personal_work_register/personal_work_register.dart';

final personalAppointmentProvider = Provider<PersonalAppointmentLogic>((ref) {
  return PersonalAppointmentLogic(ref);
});

class PersonalAppointmentLogic {
  PersonalAppointmentLogic(this.ref);

  final Ref ref;
  bool? mounted;

  Future saveForm(
      {widgetEvent,
      formKey,
      selectedValue,
      dates,
      observations,
      assignedEmployees,
      availableEmployees,
      selectedCategory}) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    List<PersonalWorkRegisterEvent> events = [];
    var miniEvents = ref.read(miniEventsProvider)!;

    if (miniEvents.isNotEmpty) {
      if (selectedValue == Constants.hours) {
        dates.add(miniEvents.first.copyWith(
          observations: observations,
          employees: assignedEmployees,
        ));
      } else {
        var miniEvents = ref.read(miniEventsProvider)!;
        for (var mini in miniEvents) {
          dates.add(mini.copyWith(
            observations: observations,
            employees: assignedEmployees,
          ));
        }
      }
    }

    for (var date in dates) {
      events.add(PersonalWorkRegisterEvent(
        employees: date.employees,
        fromDate: date.from ?? DateTime.now(),
        toDate: date.to ?? DateTime.now(),
        observations: date.observations ?? "",
        assignedEmployee: date.employees?.first ?? availableEmployees.first,
        type: selectedValue,
        eventType: selectedCategory == SelectedCategory.absence
            ? EventType.offDay
            : EventType.shift,
      ));
    }

    final isEditing = widgetEvent != null;

    var provider = getProvider(selectedCategory);

    if (isEditing) {
      for (var event in events) {
        provider.edit(
          event.copyWith(
              lastEditedBy: ref.read(userProvider).value?.name,
              lastEditedOn: DateTime.now()),
        );
      }
    } else {
      for (var event in events) {
        provider.add(event.copyWith(
          eventCreationDate: DateTime.now(),
          eventCreator: ref.read(userProvider).value?.name,
        ));
      }
    }
  }

  getProvider(isSwitched) {
    if (isSwitched == SelectedCategory.shift) {
      return ref.read(shiftProvider.notifier);
    } else {
      return ref.read(offDayProvider.notifier);
    }
  }

  void updateMiniEvents({selectedValue, date, selectedCategory, dates}) {
    if (selectedValue == Constants.hours) {
      dates.add(MiniEvent(
        from: date,
        to: date.add(const Duration(minutes: 30)),
        type: Constants.hours,
        category: selectedCategory,
      ));
    } else if (selectedValue == Constants.weekend) {
      dates.addAll(
        getWeekend(type: selectedValue, category: selectedCategory, date: date),
      );
    } else {
      dates.addAll(
        getWorkDay(type: selectedValue, category: selectedCategory, date: date),
      );
    }
  }

  getWorkDay(
      {required String type,
      required SelectedCategory category,
      required DateTime date}) {
    return [
      MiniEvent(
        from: DateTime(date.year, date.month, date.day, 9, 00, 00),
        to: DateTime(date.year, date.month, date.day, 12, 30, 00),
        type: type,
        category: category,
      ),
      MiniEvent(
        from: DateTime(date.year, date.month, date.day, 14, 00, 00),
        to: DateTime(date.year, date.month, date.day, 17, 30, 00),
        type: type,
        category: category,
      )
    ];
  }

  getWeekend({type, category, date}) {
    final DateTime saturday = _getSaturday(date);
    final DateTime sunday = saturday.add(const Duration(days: 1));
    return [
      MiniEvent(
        from: DateTime(saturday.year, saturday.month, saturday.day, 10, 00, 00),
        to: DateTime(saturday.year, saturday.month, saturday.day, 12, 30, 00),
        type: type,
        category: category,
      ),
      MiniEvent(
        from: DateTime(saturday.year, saturday.month, saturday.day, 14, 00, 00),
        to: DateTime(saturday.year, saturday.month, saturday.day, 17, 00, 00),
        type: type,
        category: category,
      ),
      MiniEvent(
        from: DateTime(sunday.year, sunday.month, sunday.day, 10, 00, 00),
        to: DateTime(sunday.year, sunday.month, sunday.day, 12, 30, 00),
        type: type,
        category: category,
      ),
      MiniEvent(
        from: DateTime(sunday.year, sunday.month, sunday.day, 14, 00, 00),
        to: DateTime(sunday.year, sunday.month, sunday.day, 17, 00, 00),
        type: type,
        category: category,
      ),
    ];
  }

  DateTime _getSaturday(DateTime date) {
    final int difference = DateTime.saturday - date.weekday;
    return date.add(Duration(days: difference));
  }
}
