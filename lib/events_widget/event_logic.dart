// In event_editing_logic.dart
import 'package:ccv_manager/events_widget/provider/event_provider.dart';
import 'package:ccv_manager/home_page/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cultural_events/cultural_event.dart';
import '../shift_off_day_widget/provider/shift_absence_logic.dart';

final culturalEventEditingProvider = Provider<CulturalEventEditingLogic>((ref) {
  return CulturalEventEditingLogic(ref);
});

class CulturalEventEditingLogic {
  final Ref ref;
  bool? mounted;
  CulturalEvent? widgetEvent;
  CulturalEvent? event;

  CulturalEventEditingLogic(this.ref);

  remove(CulturalEvent? widgetEvent, CulturalEvent event) async {
    this.event = event;
    this.widgetEvent = widgetEvent;

    //!TODO: Create notification for all users
    await ref.read(eventsProvider.notifier).remove(event);

    //TODO: Delete shifts
    await ref.read(shiftAbsenceLogicProvider).removeShift(event);
  }

  Future saveForm(
      CulturalEvent widgetEvent, CulturalEvent event, bool mounted) async {
    this.mounted = mounted;
    final isEditing = widgetEvent != null;

    final CulturalEvent e = event.copyWith(
      isAllDay: false,
    );

    var editor = ref.read(userProvider).value?.name;
    var date = DateTime.now();

    if (isEditing) {
      _updateEvent(e.copyWith(lastEditedBy: editor, lastEditedOn: date));
    } else {
      _insertEvent(e.copyWith(
        eventCreator: editor,
        eventCreationDate: date,
      ));
    }
  }

  _insertEvent(CulturalEvent e) async {
    try {
      await ref.read(eventsProvider.notifier).add(e).then((_) {
        // If this line prints, we successfully entered the `add` method.
        print('Event added successfully: ${e.id}');
        ref.read(shiftAbsenceLogicProvider).createEmployeeShift(e);
      });
    } catch (error) {
      // If an error occurs, it will be printed here.
      print('Failed to add event: $error');
    }
  }

  _updateEvent(CulturalEvent e) async {
    try {
      await ref.read(eventsProvider.notifier).edit(e).then((_) {
        print('Event updated successfully: ${e.id}');
        ref.read(shiftAbsenceLogicProvider).replaceEmployeeShift(e);
      });
    } catch (error) {
      // If an error occurs, it will be printed here.
      print('Failed to add event: $error');
    }
  }
}
