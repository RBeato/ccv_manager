import 'package:ccv_manager/common/general_card_scroll_view/general_card_scroll_view.dart';
import 'package:ccv_manager/common/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../home_page/provider/filters_provider.dart';

class CalendarListToggleWidget extends ConsumerWidget {
  const CalendarListToggleWidget(this.data, {Key? key}) : super(key: key);
  final List data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeViewSelection = ref.watch(filtersProvider).eventView;

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          // Changed from Flexible to Expanded
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: typeViewSelection?.selectedItem ==
                    Constants.calendarPageViews[0]
                ? CalendarWidget(data)
                : GeneralCardListWidget(data),
          ),
        ),
      ],
    );
  }
}
