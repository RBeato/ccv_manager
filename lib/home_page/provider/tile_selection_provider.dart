import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';

final pageSelectionProvider =
    StateProvider<PageSelection>((ref) => PageSelection.events);
