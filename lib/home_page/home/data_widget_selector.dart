import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/calendar_list_toggle.dart';
import '../../common/general_card_scroll_view/general_card_scroll_view.dart';
import '../../constants/constants.dart';
import '../../settings_widget/settings_widget.dart';
import '../provider/page_content_data_provider.dart';
import '../provider/tile_selection_provider.dart';

class HomeDataWidgetSelector extends ConsumerWidget {
  const HomeDataWidgetSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageSelectionProvider);
    final eventsData = ref.watch(dataProvider);
    Widget widget = const Text('Não há informação para mostrar');

    return eventsData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const Text('Ocorreu um erro! Por favor informe o administrador'),
        data: (data) {
          print(data);
          if (page == PageSelection.events ||
              page == PageSelection.hostel ||
              page == PageSelection.shiftsAndOffDays ||
              page == PageSelection.visitorsRegister) {
            widget = CalendarListToggleWidget(data);
          }
          if (page == PageSelection.library ||
              page == PageSelection.notifications ||
              page == PageSelection.suggestions ||
              page == PageSelection.todo ||
              page == PageSelection.devilCostumes) {
            widget = GeneralCardListWidget(data);
          }
          if (page == PageSelection.settings) {
            widget = const SettingsWidget();
          }
          // return Text(data.toString());

          return widget;
        });
  }
}
