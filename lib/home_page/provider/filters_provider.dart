import 'package:ccv_manager/home_page/provider/employees_provider.dart';
import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ccv_manager/constants/constants.dart';

import '../../models/layout_helper_models/filter.dart';
import '../../models/layout_helper_models/filter_manager.dart';
import 'tile_selection_provider.dart';

final filtersProvider =
    StateNotifierProvider<FilterNotifier, FilterManager>((ref) {
  return FilterNotifier(ref)..init();
});

class FilterNotifier extends StateNotifier<FilterManager> {
  FilterNotifier(this.ref) : super(FilterManager());

  final Ref ref;
  final FirestoreService _firestoreService = FirestoreService();

  init() async {
    var employees = ref.watch(employeesNamesProvider);

    state = FilterManager(
        eventView: Filter(
          title: Constants.eventView,
          items: Constants.calendarPageViews,
          selectedItem: Constants.calendarPageViews.first,
        ),
        eventType: Filter(
          title: Constants.eventType,
          items: Constants.eventList,
          selectedItem: Constants.eventList.first,
        ),
        employeeActivityOption: Filter(
          title: Constants.employeeActivityOptions,
          items: Constants.employeeActivityOptionsList,
          selectedItem: Constants.employeeActivityOptionsList.first,
        ),
        employee: Filter(
          title: Constants.employee,
          items: employees,
          selectedItem: "Todos",
        ),
        todo: Filter(
          title: Constants.employee,
          items: employees,
          selectedItem: "Todos",
        ),
        devilCostumes: Filter(
            title: Constants.devilCostumes,
            items: Constants.requestOptions,
            selectedItem: Constants.requestOptions.first),
        library: Filter(
          title: Constants.libraryRequests,
          items: Constants.requestOptions,
          selectedItem: Constants.requestOptions.first,
        ));
  }

  void updateFilter(Filter filter) {
    switch (filter.title) {
      case Constants.eventView:
        state = state.copyWith(filterManager: FilterManager(eventView: filter));
        break;
      case Constants.eventType:
        state = state.copyWith(filterManager: FilterManager(eventType: filter));
        break;
      case Constants.employee:
        state = state.copyWith(filterManager: FilterManager(employee: filter));
        break;
      case Constants.libraryRequests:
        state = state.copyWith(filterManager: FilterManager(library: filter));
        break;
      case Constants.devilCostumes:
        state =
            state.copyWith(filterManager: FilterManager(devilCostumes: filter));
        break;
      case Constants.employeeTodo:
        state = state.copyWith(filterManager: FilterManager(todo: filter));
        break;
      case Constants.employeeSuggestion:
        state =
            state.copyWith(filterManager: FilterManager(suggestions: filter));
        break;
      case Constants.employeeActivityOptions:
        state = state.copyWith(
            filterManager: FilterManager(employeeActivityOption: filter));
        break;
    }
  }

  get listOfFilter {
    final currentPage = ref.read(pageSelectionProvider);
    List<Filter> filters = [];
    switch (currentPage) {
      case PageSelection.events:
        filters.addAll([state.eventType!, state.eventView!]);
        break;
      case PageSelection.shiftsAndOffDays:
        filters.addAll(
            [state.employeeActivityOption!, state.employee!, state.eventView!]);
        break;
      case PageSelection.visitorsRegister:
        filters.addAll([state.eventView!]);
        break;
      case PageSelection.library:
        filters.addAll([state.library!]);
        break;
      case PageSelection.ticketOffice:
        break;
      case PageSelection.todo:
        filters.addAll([state.todo!]);
        break;
      case PageSelection.suggestions:
        filters.addAll([state.hostel!]);
        break;
      case PageSelection.devilCostumes:
        filters.addAll([state.devilCostumes!]);
        break;
      case PageSelection.notifications:
        break;
      case PageSelection.requisition:
        break;
      case PageSelection.settings:
        break;
      case PageSelection.hostel:
        filters.addAll([state.eventView!]);
        break;
    }
    return filters;
  }
}
