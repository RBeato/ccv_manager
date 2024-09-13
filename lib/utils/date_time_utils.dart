import 'package:ccv_manager/models/personal_work_register/mini_event.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../shift_off_day_widget/shift_offday_editing_page/form_switch.dart';

class DateTimeUtils {
  static String toDateTimeString(DateTime dateTime) {
    final date = DateFormat('dd-MM-yyyy').format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date - $time';
  }

  static String toDateString(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime).toString();
  }

  static String toTimeString(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime).toString();
  }

  static checkFromIsBeforeTo(DateTime newDateTime, MiniEvent masterEvent) {
    if (masterEvent.to!.isBefore(newDateTime)) {
      masterEvent = masterEvent.copyWith(from: newDateTime, to: newDateTime);
    } else {
      masterEvent = masterEvent.copyWith(from: newDateTime);
    }
    return masterEvent;
  }

  static checkToIsAfterFrom(DateTime newDateTime, MiniEvent masterEvent) {
    if (newDateTime.isBefore(masterEvent.from!)) {
      masterEvent = masterEvent.copyWith(from: masterEvent.to);
      return [masterEvent, false];
    } else {
      masterEvent =
          masterEvent.copyWith(from: masterEvent.from!, to: newDateTime);
      return [masterEvent, false];
    }
  }

  static createMiniEvents(
      MiniEvent masterEvent, String type, SelectedCategory category) {
    var dates = [];
    if (type == Constants.vacation || type == Constants.medicalCertificate) {
      dates = [
        MiniEvent(
          from: DateTime(masterEvent.from!.year, masterEvent.from!.month,
              masterEvent.from!.day, 09, 00, 00),
          to: DateTime(masterEvent.from!.year, masterEvent.from!.month,
              masterEvent.from!.day, 17, 00, 00),
          type: Constants.holiday,
          category: category,
        ),
      ];

      if (masterEvent.to != null && masterEvent.from != null) {
        while (masterEvent.from!.isBefore(masterEvent.to!)) {
          dates.add(
            MiniEvent(
              from: DateTime(masterEvent.from!.year, masterEvent.from!.month,
                  masterEvent.from!.day, 09, 00, 00),
              to: DateTime(masterEvent.from!.year, masterEvent.from!.month,
                  masterEvent.from!.day, 17, 00, 00),
              type: Constants.holiday,
              category: category,
            ),
          );
          masterEvent = masterEvent.copyWith(
              from: masterEvent.from!.add(const Duration(days: 1)));
        }
        print(dates);
      }
    }
    return dates;
  }

  static List<MiniEvent> createDailyShiftMiniEvents(
      DateTime dateTime, SelectedCategory category) {
    return [
      MiniEvent(
        from: DateTime(dateTime.year, dateTime.month, dateTime.day, 10, 00, 00),
        to: DateTime(dateTime.year, dateTime.month, dateTime.day, 12, 30, 00),
        type: Constants.holiday,
        category: category,
      ),
      MiniEvent(
        from: DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 00, 00),
        to: DateTime(dateTime.year, dateTime.month, dateTime.day, 17, 00, 00),
        type: Constants.holiday,
        category: category,
      )
    ];
  }

  static List<MiniEvent> createWholeDayMiniEvent(
      DateTime dateTime, SelectedCategory category) {
    return [
      MiniEvent(
        from: DateTime(dateTime.year, dateTime.month, dateTime.day, 09, 00, 00),
        to: DateTime(dateTime.year, dateTime.month, dateTime.day, 17, 00, 00),
        type: Constants.holiday,
        category: category,
      )
    ];
  }

  static createWeekendDatesMiniEvents(
      DateTime selectedDate, SelectedCategory category) {
    var dates = [];
    final DateTime saturday = _getSaturday(selectedDate);
    final DateTime sunday = saturday.add(const Duration(days: 1));
    dates = [
      MiniEvent(
        from: DateTime(saturday.year, saturday.month, saturday.day, 10, 00, 00),
        to: DateTime(saturday.year, saturday.month, saturday.day, 12, 30, 00),
        type: Constants.weekend,
        category: category,
      ),
      MiniEvent(
        from: DateTime(saturday.year, saturday.month, saturday.day, 14, 00, 00),
        to: DateTime(saturday.year, saturday.month, saturday.day, 17, 00, 00),
        type: Constants.weekend,
        category: category,
      ),
      MiniEvent(
        from: DateTime(sunday.year, sunday.month, sunday.day, 10, 00, 00),
        to: DateTime(sunday.year, sunday.month, sunday.day, 12, 30, 00),
        type: Constants.weekend,
        category: category,
      ),
      MiniEvent(
        from: DateTime(sunday.year, sunday.month, sunday.day, 14, 00, 00),
        to: DateTime(sunday.year, sunday.month, sunday.day, 17, 00, 00),
        type: Constants.weekend,
        category: category,
      ),
    ];
    return dates;
  }

  static DateTime _getSaturday(DateTime date) {
    final int difference = DateTime.saturday - date.weekday;
    return date.add(Duration(days: difference));
  }
}
