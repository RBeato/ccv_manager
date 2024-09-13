import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/cultural_events/auditorium.dart';

final auditoriumDataProvider =
    StateProvider<Auditorium>((ref) => Auditorium(register: []));
