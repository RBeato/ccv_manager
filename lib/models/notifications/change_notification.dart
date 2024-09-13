import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/models/library_models/book_request.dart';

import '../employee.dart';

class InfoNotification {
  String id;
  String title;
  DateTime date;
  String? description;
  List<Employee>? employees;
  EventType eventType;
  RequisitionStatus? status;
  InfoNotification({
    required this.id,
    required this.title,
    required this.date,
    this.description,
    this.employees,
    required this.eventType,
    this.status,
  });
}
