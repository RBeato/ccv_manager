import 'package:ccv_manager/devil_costumes/providers/costume_requisition_provider.dart';
import 'package:ccv_manager/events_widget/provider/event_provider.dart';
import 'package:ccv_manager/models/library_models/hostel_page/hostel_entry_view_card.dart';
import 'package:ccv_manager/models/library_models/hostel_page/hostel_entry_view_page.dart';
import 'package:ccv_manager/library_widget/providers/book_provider.dart';
import 'package:ccv_manager/models/library_models/book_request.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/offday_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/provider/shift_provider.dart';
import 'package:ccv_manager/shift_off_day_widget/shift_off_day_view/shift_off_day_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../devil_costumes/costume_request_card_view_page.dart';
import '../../devil_costumes/devil_costume_card.dart';
import '../../events_widget/event_card.dart';
import '../../events_widget/event_view/event_view_page.dart';
import '../../home_page/provider/tile_selection_provider.dart';
import '../../models/library_models/hostel_page/providers/hostel_data_provider.dart';
import '../../library_widget/book_card.dart';
import '../../library_widget/book_request_card_view_page.dart';
import '../../notifications_widget/notification_card.dart';
import '../../shift_off_day_widget/shift_offday_editing_page/personal_appointment_card.dart';
import '../../todo_widget/todo_card.dart';
import '../../todo_widget/todo_view_page/todo_view_page.dart';
import '../../visitor_register/visitor_data_card.dart';
import '../provider/task_widget_data_provider.dart';
import 'data_card_gesture_detector.dart';

class GeneralCard extends ConsumerStatefulWidget {
  const GeneralCard({this.item, this.constraints, super.key});
  final BoxConstraints? constraints;

  final item;

  @override
  ConsumerState<GeneralCard> createState() => _GeneralCardState();
}

class _GeneralCardState extends ConsumerState<GeneralCard> {
  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(pageSelectionProvider);

    if (selectedPage == PageSelection.events) {
      return DataCardGestureDetector(
        viewPage: EventViewPage(widget.item),
        card: EventCard(
          item: widget.item,
          constraints: widget.constraints,
        ),
      );
    }
    if (selectedPage == PageSelection.library) {
      return DataCardGestureDetector(
        viewPage: widget.item.deliveryDate != null
            ? null
            : BookRequestCardViewPage(widget.item),
        card: BookCard(item: widget.item, constraints: widget.constraints),
      );
    }
    if (selectedPage == PageSelection.shiftsAndOffDays) {
      return DataCardGestureDetector(
        card: PersonalAppointmentCard(
          item: widget.item,
          constraints: widget.constraints,
        ),
      );
    }
    if (selectedPage == PageSelection.visitorsRegister) {
      return DataCardGestureDetector(
        card: VisitorDataCard(
          item: widget.item,
          constraints: widget.constraints,
        ),
      );
    }
    if (selectedPage == PageSelection.hostel) {
      return DataCardGestureDetector(
        viewPage: HostelEntryViewPage(widget.item),
        card: HostelEntryViewCard(
          item: widget.item,
          constraints: widget.constraints,
        ),
      );
    }
    if (selectedPage == PageSelection.todo) {
      return DataCardGestureDetector(
        viewPage: widget.item.isCompleted != null
            ? null
            : TodoCardViewPage(
                todo: widget.item,
                constraints: widget.constraints,
              ),
        card: TodoCard(item: widget.item, constraints: widget.constraints),
      );
    }
    if (selectedPage == PageSelection.devilCostumes) {
      return DataCardGestureDetector(
        viewPage: widget.item.status == RequisitionStatus.delivered
            ? null
            : CostumeRequestCardViewPage(
                item: widget.item, constraints: widget.constraints),
        card: DevilCostumeCard(
            item: widget.item, constraints: widget.constraints),
      );
    }
    if (selectedPage == PageSelection.notifications) {
      return DataCardGestureDetector(
        viewPage: widget.item.status != null &&
                widget.item.status == RequisitionStatus.delivered
            ? null
            : getViewPage(widget.item),
        card: NotificationCard(widget.item),
      );
    }
    return const Text("Não há informação para mostrar");
  }

  getViewPage(item) {
    var word = item.eventType.toString().split('.').last;
    if ([
      "meeting",
      "activity",
      "concert",
      "theater",
      "dance",
      "roomReservation"
    ].contains(word)) {
      try {
        var e = ref
            .watch(eventsProvider)
            .where((element) => element.id == item.id)
            .first;
        return EventViewPage(e);
      } catch (e) {
        print(e);
      }
    }
    if (word == "task") {
      try {
        var e = ref
            .watch(todoDataProvider)
            .where((element) => element.id == item.id)
            .first;
        return TodoCardViewPage(todo: e);
      } catch (e) {
        print(e);
      }
    }
    if (word == "bookRequest") {
      try {
        var e = ref
            .watch(bookProvider)
            .where((element) => element.id == item.id)
            .first;
        return BookRequestCardViewPage(e);
      } catch (e) {
        print(e);
      }
    }
    if (word == "devilCostume") {
      try {
        var e = ref
            .watch(devilCostumeRequisitionProvider)
            .where((element) => element.id == item.id)
            .first;
        return CostumeRequestCardViewPage(item: e);
      } catch (e) {
        print(e);
      }
    }
    if (word == "hostelReservation") {
      try {
        var e = ref
            .watch(hostelProvider)
            .where((element) => element.id == item.id)
            .first;
        return HostelEntryViewPage(e);
      } catch (e) {
        print(e);
      }
    }
    if (word == "shift") {
      try {
        var e = ref
            .watch(shiftProvider)
            .where((element) => element.id == item.id)
            .first;
        return ShiftOffDayViewingPage(e);
      } catch (e) {
        print(e);
      }
      if (word == "offDay") {
        try {
          var e = ref
              .watch(offDayProvider)
              .where((element) => element.id == item.id)
              .first;
          return ShiftOffDayViewingPage(e);
        } catch (e) {
          print(e);
        }
      } else {
        return null;
      }
    }
  }
}
