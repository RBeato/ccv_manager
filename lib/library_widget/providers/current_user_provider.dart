import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/library_models/library_user.dart';

StateProvider<LibraryUser?> currentLibraryUserProvider =
    StateProvider((ref) => null);
