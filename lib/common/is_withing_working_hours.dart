DateTime findEaster(int year) {
  var a = year % 19;
  var b = year ~/ 100;
  var c = year % 100;
  var d = b ~/ 4;
  var e = b % 4;
  var f = (b + 8) ~/ 25;
  var g = (b - f + 1) ~/ 3;
  var h = (19 * a + b - d - g + 15) % 30;
  var i = c ~/ 4;
  var k = c % 4;
  var l = (32 + 2 * e + 2 * i - h - k) % 7;
  var m = (a + 11 * h + 22 * l) ~/ 451;
  var month = (h + l - 7 * m + 114) ~/ 31;
  var day = ((h + l - 7 * m + 114) % 31) + 1;
  return DateTime(year, month, day);
}

List<DateTime> generateHolidays() {
  List<DateTime> holidays = [];
  var year = DateTime.now().year;

  holidays.add(DateTime(year, 1, 1)); // New Year's Day
  holidays.add(DateTime(year, 4, 25)); // Freedom Day
  holidays.add(DateTime(year, 5, 1)); // Labor Day
  holidays.add(DateTime(year, 5, 20)); // Your custom holiday on May 20
  holidays.add(DateTime(year, 6, 10)); // Portugal Day
  holidays.add(DateTime(year, 8, 15)); // Assumption of Mary
  holidays.add(DateTime(year, 10, 5)); // Republic Day
  holidays.add(DateTime(year, 11, 1)); // All Saints' Day
  holidays.add(DateTime(year, 12, 1)); // Restoration of Independence
  holidays.add(DateTime(year, 12, 8)); // Immaculate Conception
  holidays.add(DateTime(year, 12, 25)); // Christmas Day

  // Moveable holidays
  DateTime easter = findEaster(year); // Easter Sunday
  holidays.add(easter
      .subtract(const Duration(days: 47))); // Carnival (47 days before Easter)
  holidays.add(easter
      .subtract(const Duration(days: 2))); // Good Friday (2 days before Easter)
  holidays.add(easter
      .add(const Duration(days: 60))); // Corpus Christi (60 days after Easter)

  return holidays;
}

bool isHoliday(DateTime date) {
  List<DateTime> holidays = generateHolidays();
  for (DateTime holiday in holidays) {
    if (holiday.year == date.year &&
        holiday.month == date.month &&
        holiday.day == date.day) {
      return true;
    }
  }
  return false;
}

bool isWithinWorkingHours(DateTime from, DateTime to) {
  if (from.weekday < DateTime.monday ||
      from.weekday > DateTime.friday ||
      isHoliday(from)) {
    return false; // Check if the start date is not a weekday or a holiday
  }

  // Define the start and end time of the working hours
  final startTimeMorning = DateTime(from.year, from.month, from.day, 9, 0);
  final endTimeMorning = DateTime(from.year, from.month, from.day, 12, 0);
  final startTimeAfternoon = DateTime(from.year, from.month, from.day, 14, 0);
  final endTimeAfternoon = DateTime(from.year, from.month, from.day, 17, 30);

  // Check if the interval is within the working hours
  final isWithinMorningHours =
      from.isAfter(startTimeMorning) && to.isBefore(endTimeMorning);
  final isWithinAfternoonHours =
      from.isAfter(startTimeAfternoon) && to.isBefore(endTimeAfternoon);

  return isWithinMorningHours || isWithinAfternoonHours;
}



// bool isWithinWorkingHours(DateTime from, DateTime to) {
//   if (from.weekday < DateTime.monday || from.weekday > DateTime.friday) {
//     return false; // Check if the start date is not a weekday
//   }

//   // Define the start and end time of the working hours
//   final startTimeMorning = DateTime(from.year, from.month, from.day, 9, 0);
//   final endTimeMorning = DateTime(from.year, from.month, from.day, 12, 0);
//   final startTimeAfternoon = DateTime(from.year, from.month, from.day, 14, 0);
//   final endTimeAfternoon = DateTime(from.year, from.month, from.day, 17, 30);

//   // Check if the interval is within the working hours
//   final isWithinMorningHours =
//       from.isAfter(startTimeMorning) && to.isBefore(endTimeMorning);
//   final isWithinAfternoonHours =
//       from.isAfter(startTimeAfternoon) && to.isBefore(endTimeAfternoon);

//   return isWithinMorningHours || isWithinAfternoonHours;
// }
