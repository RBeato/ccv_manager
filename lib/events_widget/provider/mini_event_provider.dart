import 'package:ccv_manager/models/personal_work_register/mini_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final miniEventsProvider = StateProvider<List<MiniEvent>?>((ref) {
  return [];
});
