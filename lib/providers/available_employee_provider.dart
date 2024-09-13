import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_page/provider/employees_provider.dart';
import '../models/employee.dart';
import '../models/personal_work_register/mini_event.dart';
import '../shift_off_day_widget/provider/offday_provider.dart';

final availableEmployeesProvider =
    StateNotifierProvider<AvailableEmployeesNotifier, List<Employee>>((ref) {
  return AvailableEmployeesNotifier(ref);
});

class AvailableEmployeesNotifier extends StateNotifier<List<Employee>> {
  AvailableEmployeesNotifier(this.ref) : super([]) {
    getAllEmployees();
  }

  final Ref ref;

  getAllEmployees() {
    state = ref.watch(employeesProvider).value!
      ..removeWhere((element) => element.name == "Artur Marques");
  }

  List<Employee> filterEmployees(MiniEvent event) {
    final List<Employee> availableEmployees = [...state];

    final filteredEmployees = availableEmployees.where((employee) {
      return isEventOverlapping(event, employee);
    }).toList();

    return filteredEmployees;
  }

  bool isEventOverlapping(MiniEvent event, Employee employee) {
    final events = ref
        .read(offDayProvider.notifier)
        .getOffDaysForEmployee(employee.authId);

    // Handle empty list
    if (events.isEmpty) return true;

    for (final existingEvent in events) {
      // Null safety checks
      if (event.from == null || event.to == null) {
        // Handle null values appropriately
        continue;
      }

      // Check for overlaps including edge cases
      if ((existingEvent.fromDate.isBefore(event.to!) &&
              existingEvent.toDate.isAfter(event.from!)) ||
          (existingEvent.fromDate.isAtSameMomentAs(event.to!) ||
              existingEvent.toDate.isAtSameMomentAs(event.from!)) ||
          (event.from!.isBefore(existingEvent.toDate) &&
              event.to!.isAfter(existingEvent.fromDate)) ||
          (event.from!.isAtSameMomentAs(existingEvent.toDate) ||
              event.to!.isAtSameMomentAs(existingEvent.fromDate))) {
        return false;
      }
    }
    return true;
  }
}
