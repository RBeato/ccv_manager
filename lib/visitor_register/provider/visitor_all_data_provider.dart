import 'package:ccv_manager/visitor_register/provider/visitorProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final visitorsDataProvider = FutureProvider<Map>((ref) async {
  var todayVisits = await ref.watch(visitorProvider.notifier).getTodayVisits();
  var weeklyVisits =
      await ref.watch(visitorProvider.notifier).getWeeklyVisits();
  var monthlyVisits =
      await ref.watch(visitorProvider.notifier).getMonthlyVisits();
  var yearlyVisits =
      await ref.watch(visitorProvider.notifier).getYearlyVisits();
  return {
    'todayVisits': todayVisits,
    'weeklyVisits': weeklyVisits,
    'monthlyVisits': monthlyVisits,
    'yearlyVisits': yearlyVisits,
  };
});
