import 'filter.dart';

class FilterManager {
  Filter? eventType,
      eventView,
      employee,
      employeeActivityOption,
      visitorRegister,
      library,
      tickets,
      todo,
      suggestions,
      devilCostumes,
      hostel,
      notifications;

  FilterManager({
    this.eventType,
    this.eventView,
    this.employee,
    this.employeeActivityOption,
    this.visitorRegister,
    this.library,
    this.tickets,
    this.todo,
    this.suggestions,
    this.devilCostumes,
    this.hostel,
    this.notifications,
  });

  FilterManager copyWith({required FilterManager filterManager}) {
    return FilterManager(
      eventType: filterManager.eventType ?? eventType,
      eventView: filterManager.eventView ?? eventView,
      employeeActivityOption:
          filterManager.employeeActivityOption ?? employeeActivityOption,
      employee: filterManager.employee ?? employee,
      visitorRegister: filterManager.visitorRegister ?? visitorRegister,
      library: filterManager.library ?? library,
      tickets: filterManager.tickets ?? tickets,
      todo: filterManager.todo ?? todo,
      suggestions: filterManager.suggestions ?? suggestions,
      devilCostumes: filterManager.devilCostumes ?? devilCostumes,
      notifications: filterManager.notifications ?? notifications,
      hostel: filterManager.hostel ?? hostel,
    );
  }
}
