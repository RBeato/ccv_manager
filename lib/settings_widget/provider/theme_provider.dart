import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';

final themeProvider = StateProvider<ThemeType>((ref) => ThemeType.light);
