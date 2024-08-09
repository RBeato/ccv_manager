import 'package:ccv_manager/events_widget/event_view/auditorium_page.dart';
import 'package:flutter/material.dart';

import '../../models/calendar_event/calendar_event.dart';
import '../../models/cultural_events/cultural_event.dart';

class AuditoriumButton extends StatelessWidget {
  const AuditoriumButton(this.event, {super.key});

  final CulturalEvent event;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AuditoriumPage(event)));
      },
      child: const Text("Mapa do auditório"),
    );
  }
}
