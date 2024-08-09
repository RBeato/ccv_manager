import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final employeesProvider = FutureProvider<List<Employee>>((ref) async {
  FirestoreService firestoreService = FirestoreService();
  List<Employee> employees = [];

  var value = await firestoreService.getAll(FirestoreCollection.users);

  for (var document in value.docs) {
    employees.add(Employee.fromSnapshot(document));
  }
  return employees;
});

// final employeesProvider = FutureProvider<List<Employee>>((ref) async {
//   return [
//     Employee(
//         name: "Romeu Beato",
//         email: "romeu.beato@cm-vinhais.pt",
//         id: "46iVx0sSU1ZFykGgmLjdyUSoACf1",
//         role: "admin"),
//   ];
// });

final employeesNamesProvider = StateProvider<List<String>>((ref) {
  var employees =
      ref.watch(employeesProvider).value!.map((e) => e.name).toList();

  employees.removeWhere((element) => element == "Artur Marques");

  return employees
    ..sort((a, b) => a.compareTo(b))
    ..insert(0, "Todos");
});
