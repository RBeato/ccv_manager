import 'package:ccv_manager/events_widget/event_view/provider/auditorium_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/constants.dart';
import '../../models/calendar_event/calendar_event.dart';

import '../../models/cultural_events/auditorium.dart';
import '../../models/cultural_events/cultural_event.dart';
import 'category_selection_button.dart';

class AuditoriumWidget extends ConsumerStatefulWidget {
  const AuditoriumWidget(this.event, {super.key});
  final CulturalEvent event;

  @override
  _AuditoriumWidgetState createState() => _AuditoriumWidgetState();
}

class _AuditoriumWidgetState extends ConsumerState<AuditoriumWidget> {
  List<List<bool>> _seatStatuses = [];

  Map<String, String> seatType = {};
  String typeSelection = Constants.regular;
  late Auditorium auditorium;

  List seatRows = [
    "M",
    "L",
    "K",
    "J",
    "I",
    "H",
    "G",
    "F",
    "E",
    "D",
    "C",
    "B",
    "A"
  ];

  List seatNumbers = [
    "18",
    "17",
    "16",
    "15",
    "14",
    "13",
    "12",
    "11",
    "10",
    "9",
    "8",
    "7",
    "6",
    "5",
    "4",
    "3",
    "2",
    "1"
  ];

  @override
  void initState() {
    super.initState();

    auditorium = widget.event.auditorium ?? Auditorium(register: []);

    _seatStatuses = List.generate(
      13,
      (i) => List.generate(
        _getNumSeatsInRow(i),
        (j) => false,
      ),
    );

    if (auditorium.register!.isNotEmpty) {
      populateAuditorium();
    }
  }

  populateAuditorium() {
    for (var seat in widget.event.auditorium!.register!) {
      var row = seat.seat.substring(0, 1);
      var number = seat.seat.substring(1);
      var rowIndex = seatRows.indexOf(row);
      var seatIndex = seatNumbers.indexOf(number);

      seatType["$rowIndex$seatIndex"] =
          Constants.auditoriumAttendantToString[seat.attendant]!;

      _seatStatuses[rowIndex][seatIndex] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final availableWidth = constraints.maxWidth;
      return Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Mapa do Auditório",
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          13,
                          (i) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _getNumSeatsInRow(i),
                                (j) {
                                  return GestureDetector(
                                      onTap: () => updateAuditorium(i, j),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3.0),
                                        child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: availableWidth * 0.05,
                                              minHeight: 30,
                                              maxHeight: double.infinity,
                                              maxWidth: double.infinity,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black38,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _seatStatuses[i][j]
                                                  ? getColor(seatType["$i$j"]!)
                                                  : null,
                                            ),
                                            child: Center(
                                              child: Text(
                                                seatRows[i] + seatNumbers[j],
                                                style: TextStyle(
                                                    color: _seatStatuses[i][j]
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            )),
                                      ));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CategorySelectionButton(
                    title: Constants.junior,
                    selection: typeSelection,
                    onPressed: () => changeSelection(Constants.junior)),
                const SizedBox(width: 10),
                CategorySelectionButton(
                    title: Constants.regular,
                    selection: typeSelection,
                    onPressed: () => changeSelection(Constants.regular)),
                const SizedBox(width: 10),
                CategorySelectionButton(
                    title: Constants.senior,
                    selection: typeSelection,
                    onPressed: () => changeSelection(Constants.senior)),
              ],
            ),
          ))
        ],
      );
    });
  }

  updateAuditorium(i, j) {
    if (_seatStatuses[i][j] == false) {
      seatType["$i$j"] = typeSelection;

      auditorium.register!.add(AuditoriumSeat(
          seat: seatRows[i] + seatNumbers[j],
          attendant: Attendant.values
              .toList()
              .firstWhere((a) => a.name == typeSelection.toLowerCase())));
    }
    if (_seatStatuses[i][j] == true) {
      auditorium.register!
          .removeWhere((e) => e.seat == seatRows[i] + seatNumbers[j]);
    }

    ref.read(auditoriumDataProvider.notifier).update((state) => auditorium);
    setState(() {
      _seatStatuses[i][j] = !_seatStatuses[i][j];
    });
  }

  getColor(String selection) {
    Color color = Colors.white;
    switch (selection) {
      case Constants.junior:
        color = Colors.lightBlue[200]!;
        break;
      case Constants.regular:
        color = Colors.teal;
        break;
      case Constants.senior:
        color = Colors.purple;
        break;
      default:
    }
    return color;
  }

  changeSelection(String selection) {
    setState(() {
      typeSelection = selection;
    });
    print(typeSelection);
  }

  int _getNumSeatsInRow(int row) {
    switch (row) {
      case 0:
        return 15;
      // case 12:
      //   return 10;
      default:
        return 18;
    }
  }
}
