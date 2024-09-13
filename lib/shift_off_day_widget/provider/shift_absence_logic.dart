import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/offday_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/shift_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/is_withing_working_hours.dart';
import '../../models/cultural_events/cultural_event.dart';
import '../../models/personal_work_register/personal_work_register.dart';
import '../../models/todos/todo.dart';
import '../../todo_widget/provider/todo_provider.dart';

final shiftAbsenceLogicProvider = Provider<ShiftAbsenceLogic>((ref) {
  return ShiftAbsenceLogic(ref);
});

class ShiftAbsenceLogic {
  ShiftAbsenceLogic(this.ref);
  final Ref ref;

  removeShift(CulturalEvent event) async {
    for (var e in event.employees!) {
      await ref.read(shiftProvider.notifier).removeAllAssociatedWith(event);
    }
  }

  removeAbsence(PersonalWorkRegisterEvent event) async {
    //!TODO: If absence remove from shifts
    await ref.read(offDayProvider.notifier).remove(event);
  }

  Future<void> createEmployeeShift(CulturalEvent e) async {
    _registerEmployeeAssignment(e);
  }

  Future<void> replaceEmployeeShift(CulturalEvent e) async {
    _unRegisterEmployeesAssignment(e);
    _registerEmployeeAssignment(e);
  }

  _registerEmployeeAssignment(e) async {
    bool isWorkHours = isWithinWorkingHours(e.fromDate, e.toDate);
    {
      for (var employee in e.employees!) {
        // if (mounted!) {
        if (isWorkHours) {
          //adds Todo that is shown in personal notifications
          await ref.read(todoProvider.notifier).add(e.copyWith(
              assignedEmployee: employee, eventType: EventType.task));
        } else {
          //creates Shift that is sent to different calendar
          await ref.read(shiftProvider.notifier).add(e.copyWith(
              assignedEmployee: employee, eventType: EventType.shift));
        }
        // }
      }
    }
  }

  _unRegisterEmployeesAssignment(CulturalEvent e) async {
    bool isWorkHours = isWithinWorkingHours(e.fromDate, e.toDate);
    {
      for (var employee in e.employees!) {
        // if (mounted!) {
        if (isWorkHours) {
          //adds Todo that is shown in personal notifications
          await ref
              .read(todoProvider.notifier)
              .removeAllAssociatedWith(TodoEvent(
                fromDate: e.fromDate,
                toDate: e.toDate,
                assignedEmployee: employee,
                eventType: EventType.task,
                description: e.title,
                parentId: e.id,
              ));
        } else {
          //creates Shift that is sent to different calendar
          await ref.read(shiftProvider.notifier).removeAllAssociatedWith(e);
        }
        // }
      }
    }
  }
}
