import 'package:ccv_manager/common/provider/date_time_field_from_to_provider.dart';
import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

import '../../../utils/date_time_utils.dart';

final exportDataProvider =
    StateNotifierProvider<ExportDataNotifier, List>((ref) {
  return ExportDataNotifier(ref);
});

class ExportDataNotifier extends StateNotifier<List> {
  ExportDataNotifier(this.ref) : super([]);

  final Ref ref;
  final FirestoreService _firestoreService = FirestoreService();
  // PageSelection? page;    final filters = ref.watch(filtersProvider);
  var docs;
  List allDocs = [];

  getData({section, filterValue, employee}) async {
    await getDocs(section);
    docs = await filterByDateInterval(section);
    docs = await pageSpecificFiltering(section, filterValue, employee);
    await exportData(section);
    state = docs;
  }

  getDocs(section) async {
    docs = await _firestoreService
        .getAll(Constants.sectionToFirestoreCollection[section]!);
  }

  exportData(section) async {
    // Determine the headers dynamically
    Set<String> headersSet = {};

    print("Docs $docs");

    // for (Document doc in docs) {
    //   print("doc.map.keys ${doc.map.keys}");
    //   headersSet.addAll(doc.map.keys);
    // }
    // List<String> headers = headersSet.toList();
    List<String> headers = Constants.headers[section]!;
    print("headers :: $headers");

    // Convert the filtered documents to a list of maps for CSV conversion
    List<List<dynamic>> rows = [];
    rows.add(headers); // Add dynamically determined CSV headers

    for (var doc in docs) {
      List<dynamic> row = [];
      for (var header in headers) {
        var data = filterColumnDataByHeader(header, doc);
        row.add(data ?? '');
      }
      rows.add(row);
    }

// Convert rows to CSV
    String csv = const ListToCsvConverter().convert(rows);

// Write CSV to file
    final directory = await getDownloadsDirectory();
    final path = directory!.path;
    final file = File(
        '$path/dados_${section}_ccv_manager_${DateTimeUtils.toDateTimeString(DateTime.now())}.csv');
    await file.writeAsString(csv);
    print("CSV Exported to $path/export.csv");
  }

  Future<List> filterByDateInterval(section) async {
    final timeFrame = ref.read(dateTimeFromToProvider);
    if (timeFrame != null) {
      DateTime startDate = timeFrame.from!;
      DateTime endDate = timeFrame.to!;

      String word = getDocTimeKey(section);

// Filter the documents by date range
      List filteredDocs = docs.where((doc) {
        DateTime docDate = DateTime.parse(doc[word]);
        return docDate.isAfter(startDate) && docDate.isBefore(endDate);
      }).toList();

      return filteredDocs;
    } else {
      return docs;
    }
  }

  String? filterColumnDataByHeader(header, doc) {
    if (header == "employees" || header == 'assignedEmployee') {
      return doc[header]['name'];
    }
    if (header == 'books') {
      var text = "";
      for (var d in doc[header]) {
        text += '${[d['name'], d['author'], d['edition']].join(", ")};';
      }
      return text;
    }
    if (header == 'costumes') {
      var text = "";
      for (var d in doc[header]) {
        text += '${[d['size'], d['quantity']].join(": ")};';
      }
      return text;
    }
    return doc[header]?.toString();
  }

  getDocTimeKey(section) {
    if ([
      Constants.devilCostumes,
      Constants.library,
    ].contains(section)) {
      return "requestDate";
    } else {
      return "from";
    }
  }

  Future<List> pageSpecificFiltering(section, filterValue, employee) async {
    if (section == Constants.events) {
      return docs.where((doc) {
        // Map<String, dynamic> data = doc.map as Map<String, dynamic>; //!
        if (filterValue == "Todos") return true;
        bool hasDesiredStatus =
            doc.map.containsKey('eventType') && doc['eventType'] == filterValue;
        return hasDesiredStatus;
      }).toList();
    }

    if (section == Constants.shiftsSlashOffDays) {
      if (filterValue != "Todas") {
        return docs;
      } else {
        return docs.where((doc) {
          bool hasDesiredStatus = doc.map.containsKey('eventType') &&
              (doc['eventType'] == "Turno" || doc['eventType'] == "Folga");
          return hasDesiredStatus;
        }).toList();
      }
    }

    if ([Constants.visitorsRegister, Constants.hostel, Constants.library]
        .contains(section)) {
      return docs;
    }

    if (section == Constants.todo) {
      if (filterValue == "Todos") {
        return docs;
      } else {
        return docs.where((doc) {
          bool isEmployee = doc.map.containsKey('employees') &&
              doc['employees'] == filterValue;

          bool hasEventType = doc.map.containsKey('eventType') &&
              doc['eventType'] == filterValue;

          return isEmployee && hasEventType;
        }).toList();
      }
    }
    return docs;
  }
}
