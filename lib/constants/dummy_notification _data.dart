import 'package:ccv_manager/constants/constants.dart';

import '../models/library_models/book_request.dart';
import '../models/notifications/change_notification.dart';

class DummyNotificationData {
  static List<InfoNotification> suggestions = [
    InfoNotification(
      id: "1234",
      title: "Tiago criou uma nova sugestão",
      description: 'Modificação de sala X',
      eventType: EventType.task,
      date: DateTime.now(),
      status: RequisitionStatus.delivered,
    ),
    InfoNotification(
      id: "123",
      title: 'Vera criou um novo evento',
      date: DateTime.now().add(const Duration(days: 1)),
      eventType: EventType.task,
      description: "Evento de teste",
      status: RequisitionStatus.toBeDelivered,
    ),
  ];
}
