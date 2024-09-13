import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shift_offday_editing_page/form_switch.dart';

final shiftAbsenceCategoryProvider =
    StateProvider<SelectedCategory>((ref) => SelectedCategory.absence);
