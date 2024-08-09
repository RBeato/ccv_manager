import 'package:ccv_manager/models/library_models/hostel_page/hostel_entry_form.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../devil_costumes/costume_form/devil_costume_form.dart';
import '../../events_widget/event_editing_page.dart';
import '../../library_widget/book_requisition_form.dart';
import '../../shift_off_day_widget/shift_offday_editing_page/personal_appointment_editing_page.dart';
import '../../suggestions_widget/new_suggestion_page.dart';
import '../../todo_widget/todo_form.dart';
import '../../visitor_register/visitor_registor_form.dart';

class NextPageFilter extends StatelessWidget {
  const NextPageFilter(this.selectedTile, {super.key});
  final PageSelection selectedTile;

  @override
  Widget build(BuildContext context) {
    if (selectedTile == PageSelection.events) {
      return const EventEditingPage();
    }

    if (selectedTile == PageSelection.library) {
      return const BookRequestForm();
    }
    if (selectedTile == PageSelection.suggestions) {
      return const SuggestionFormPage();
    }
    if (selectedTile == PageSelection.todo) {
      return TodoForm();
    }
    if (selectedTile == PageSelection.devilCostumes) {
      return DevilCostumeRequestForm();
    }
    if (selectedTile == PageSelection.ticketOffice) {
      return const Scaffold(
        body: Center(
          child: Text('Ticket Office'),
        ),
      );
    }
    if (selectedTile == PageSelection.visitorsRegister) {
      return VisitorRegisterForm();
    }
    if (selectedTile == PageSelection.shiftsAndOffDays) {
      return const PersonalAppointmentPage(null);
    }
    if (selectedTile == PageSelection.hostel) {
      return const HostelEntryForm();
    }
    return const Scaffold(body: Center(child: Text('No data to show')));
  }
}
