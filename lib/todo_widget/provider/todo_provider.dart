import 'package:ccv_manager/models/todos/todo.dart';
import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoProvider =
    StateNotifierProvider<TodoNotifier, List<TodoEvent>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<TodoEvent>> {
  TodoNotifier() : super([]) {
    getTodoList();
  }

  getTodoList() async {
    // final dummyData = DummyTodoData.todoList;
    FirestoreService firestoreService = FirestoreService();
    List<TodoEvent> savedEvents = [];
    try {
      await firestoreService.getAll(FirestoreCollection.todo).then((value) {
        for (var document in value.docs) {
          savedEvents.add(TodoEvent.fromSnapshot(document));
        }
      });
    } catch (e) {
      print(e);
    }

    // var temp = [...dummyData, ...savedEvents];
    var temp = [...savedEvents];

    state = temp..sort((a, b) => a.fromDate.compareTo(b.fromDate));
    print(state);
  }

  Future<void> add(TodoEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    var doc =
        await firestoreService.add(event.toJson(), FirestoreCollection.todo);
    event.id = doc.id;
    state = [...state, event];
  }

  Future<void> edit(TodoEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        event.id!, event.toJson(), FirestoreCollection.todo);

    state = [
      for (final e in state)
        if (event.id == e.id) event else e,
    ];
  }

  Future<void> remove(TodoEvent event) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(event.id!, FirestoreCollection.todo);
    state = [
      for (final ev in state)
        if (ev != event) ev else event
    ];
  }

  Future<void> removeAllAssociatedWith(TodoEvent event) async {
    FirestoreService firestoreService = FirestoreService();

    List todoList = state.where((e) => e.parentId == e.id).toList();

    for (var event in todoList) {
      await firestoreService.delete(event.id!, FirestoreCollection.todo);
      state = [
        for (final ev in state)
          if (ev != event) ev
      ];
    }
  }
}
