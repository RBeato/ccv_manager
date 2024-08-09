import 'package:ccv_manager/constants/constants.dart';
import '../models/hostel_register/hostel_register.dart';

class DummyReservationData {
  static List<HostelRegisterEvent> reservations = [
    HostelRegisterEvent(
      eventName: "Peregrino 1",
      fromDate: DateTime.now().subtract(const Duration(days: 4)),
      toDate: DateTime.now()
          .subtract(const Duration(days: 4))
          .add(const Duration(hours: 2)),
      type: Constants.hostelReservation,
    ),
  ];
}
