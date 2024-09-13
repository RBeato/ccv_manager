import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cultural_events/cultural_event.dart';

final eventsProvider = StateProvider<List<CulturalEvent>>((ref) {
  return [];
});
