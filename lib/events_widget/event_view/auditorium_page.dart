import 'package:ccv_manager/events_widget/event_view/provider/auditorium_data_provider.dart';
import 'package:ccv_manager/models/cultural_events/cultural_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/appbar_editing_save_button.dart';
import '../../models/cultural_events/auditorium.dart';
import '../../models/calendar_event/calendar_event.dart';
import '../../services/firebase_storing.dart';
import 'auditorium_screen.dart';

class AuditoriumPage extends ConsumerStatefulWidget {
  const AuditoriumPage(this.event, {super.key});
  final CulturalEvent event;

  @override
  ConsumerState<AuditoriumPage> createState() => _AuditoriumPageState();
}

class _AuditoriumPageState extends ConsumerState<AuditoriumPage> {
  Auditorium? auditorium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registo de entradas"),
          leading: const CloseButton(),
          actions: buildEditingActions(saveForm),
          backgroundColor: Colors.teal,
        ),
        body: AuditoriumWidget(widget.event));
  }

  Future saveForm() async {
    FirestoreService firestoreService = FirestoreService();

    var a = ref.read(auditoriumDataProvider);
    widget.event.auditorium = a;
    widget.event.numberOfPeople =
        a.register?.length ?? widget.event.numberOfPeople;

    await firestoreService
        .update(
            widget.event.id!, widget.event.toJson(), FirestoreCollection.events)
        .then((_) => Navigator.of(context).pop());
  }
}
