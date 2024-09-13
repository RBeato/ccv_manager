import 'package:ccv_manager/models/library_models/hostel_page/providers/hostel_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../devil_costumes/providers/filtered_costume_request_provider.dart';
import '../../events_widget/provider/filtered_events_provider.dart';
import '../../library_widget/providers/filtered_book_request_provider.dart';
import '../../notifications_widget/provider/notification_provider.dart';
import '../../shift_off_day_widget/provider/filtered_work_data_provider.dart';
import '../../todo_widget/provider/filtered_todo_provider.dart';
import '../../visitor_register/provider/visitorProvider.dart';
import 'tile_selection_provider.dart';

final dataProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  final page = ref.watch(pageSelectionProvider);
  switch (page) {
    case PageSelection.events:
      return await ref.watch(filteredEventsProvider); //eventsProvider);
    case PageSelection.shiftsAndOffDays:
      return await ref.watch(
          filteredWorkDataProvider); //   shiftProvider); //.notifier).getEvents();
    case PageSelection.library:
      return await ref.watch(filteredBookRequestProvider);
    case PageSelection.todo:
      return await ref.watch(filteredTodoProvider);
    case PageSelection.hostel:
      return await ref.watch(hostelProvider);
    case PageSelection.notifications:
      return ref.watch(notificationProvider); //notificationsProvider
    case PageSelection.devilCostumes:
      return await ref.watch(filteredCostumeRequestProvider);
    case PageSelection.visitorsRegister:
      return await ref.watch(visitorProvider);
    case PageSelection.settings:
      return Future.value([]);
    default:
      throw UnimplementedError('No provider for page $page');
  }
});
