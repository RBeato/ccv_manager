import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/dummy_visitor_data.dart';
import '../../models/visitors/visitor_register_event.dart';
import '../../services/firebase_storing.dart';

final visitorProvider =
    StateNotifierProvider<VisitorNotifier, List<VisitorRegisterEvent>>((ref) {
  return VisitorNotifier();
});

class VisitorNotifier extends StateNotifier<List<VisitorRegisterEvent>> {
  VisitorNotifier() : super([]) {
    getEvents();
  }

  FirestoreService firestoreService = FirestoreService();

  List<VisitorRegisterEvent> get allVsisitors => state;

  getEvents() async {
    FirestoreService firestoreService = FirestoreService();
    List<VisitorRegisterEvent> savedEvents = [];
    Map<String, int> dateVisitorCount = {};

    var docs = await firestoreService.getAll(FirestoreCollection.visitors);

    for (var document in docs.docs) {
      var event = VisitorRegisterEvent.fromSnapshot(document);
      var date = DateTimeUtils.toDateString(event.fromDate);
      if (dateVisitorCount.containsKey(date)) {
        dateVisitorCount[date] = dateVisitorCount[date]! + event.visitorCounter;
      } else {
        dateVisitorCount[date] = event.visitorCounter;
      }
    }
    dateVisitorCount.forEach((date, count) {
      List<String> dateParts = date.split("-");
      DateTime dateTime = DateTime(int.parse(dateParts[2]),
          int.parse(dateParts[1]), int.parse(dateParts[0]));
      savedEvents.add(VisitorRegisterEvent(
          id: date.toString(),
          title: 'Visitantes',
          fromDate: dateTime,
          toDate: dateTime.add(const Duration(minutes: 30)),
          visitorCounter: count));
    });

    state = [...DummyVisitorData.visitors, ...savedEvents]; //!remove this
    // state = [...savedEvents];
  }

  void updateDayCounter(VisitorRegisterEvent event) {
    //updates UI only
    state = [
      for (final e in state)
        if (DateTimeUtils.toDateString(event.fromDate) ==
            DateTimeUtils.toDateString(e.fromDate))
          VisitorRegisterEvent(
              id: event.toString(),
              title: 'Visitantes',
              fromDate: event.fromDate,
              toDate: event.toDate,
              visitorCounter: int.parse(e.visitorCounter.toString()) +
                  int.parse(event.visitorCounter.toString()))
        else
          e,
    ];
  }

  void add(VisitorRegisterEvent ev) async {
    var doc =
        await firestoreService.add(ev.toJson(), FirestoreCollection.visitors);
    ev.id = doc.id;
    updateDayCounter(ev);
  }

  void edit(VisitorRegisterEvent event) async {
    await firestoreService.update(
        event.id!, event.toJson(), FirestoreCollection.visitors);
    state = [
      for (final e in state)
        if (event.id == e.id) event else e,
    ];
  }

  void remove(VisitorRegisterEvent event) {
    state = [
      for (final ev in state)
        if (ev != event) ev
    ];
  }

  getTodayVisits() {
    return state
        .where((s) =>
            s.fromDate.year == DateTime.now().year &&
            s.fromDate.month == DateTime.now().month &&
            s.fromDate.day == DateTime.now().day)
        .fold(
            0, (accumulator, event) => accumulator + event.visitorCounter ?? 0);
  }

  getWeeklyVisits() {
    return getLastNumberDaysDate(7).fold(
        0, (accumulator, event) => accumulator + event.visitorCounter ?? 0);
  }

  getMonthlyVisits() {
    return getLastNumberDaysDate(30).fold(
        0, (accumulator, event) => accumulator + event.visitorCounter ?? 0);
  }

  getYearlyVisits() {
    return getLastNumberDaysDate(365).fold(
        0, (accumulator, event) => accumulator + event.visitorCounter ?? 0);
  }

  getLastNumberDaysDate(numberDays) {
    DateTime currentDate = DateTime.now();
    DateTime thirtyDaysAgo = currentDate.subtract(Duration(days: numberDays));

    var temp = [];
    for (DateTime date = thirtyDaysAgo;
        date.isBefore(currentDate);
        date = date.add(const Duration(days: 1))) {
      VisitorRegisterEvent tempDate;
      try {
        tempDate = state
            .where((s) =>
                s.fromDate.year == date.year &&
                s.fromDate.month == date.month &&
                s.fromDate.day == date.day)
            .first;

        temp.add(tempDate);
      } catch (e) {
        debugPrint("Bad or empty state");
      }
    }
    return temp;
  }
}
