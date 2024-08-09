import 'package:ccv_manager/home_page/provider/filters_provider.dart';
import 'package:ccv_manager/todo_widget/provider/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/dummy_todo_data.dart';
import '../../models/calendar_event/calendar_event.dart';

StateProvider<List<CalendarEvent>> filteredTodoProvider = StateProvider((ref) {
  final filters = ref.watch(filtersProvider);
  final todo = ref.watch(todoProvider);

  var result = <CalendarEvent>[];
  if (filters.todo!.selectedItem != "Todos") {
    try {
      result = todo
          .where((t) => t.employees!
              .map((e) => e.name)
              .toList()
              .contains(filters.todo!.selectedItem))
          .toList();
    } catch (e) {
      print(e);
      return todo;
    }
  } else {
    result = todo;
  }

  result.addAll(DummyTodoData.todoList); //!remove this
  return result;
});
