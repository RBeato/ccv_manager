import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/library_models/library_user.dart';

final libraryUserProvider =
    StateNotifierProvider<LibraryUserNotifier, List<LibraryUser>>((ref) {
  return LibraryUserNotifier();
});

class LibraryUserNotifier extends StateNotifier<List<LibraryUser>> {
  LibraryUserNotifier() : super([]) {
    getUsers();
  }

  List<LibraryUser> get allUsers => state;

  getUsers() async {
    List<LibraryUser> savedUsers = [];
    FirestoreService firestoreService = FirestoreService();
    await firestoreService
        .getAll(FirestoreCollection.libraryUser)
        .then((value) {
      for (var document in value.docs) {
        savedUsers.add(LibraryUser.fromSnapshot(document));
      }
    });
    state = [...savedUsers];
  }

  Future<void> add(LibraryUser user) async {
    FirestoreService firestoreService = FirestoreService();
    var doc = await firestoreService.add(
        user.toMap(), FirestoreCollection.libraryUser);
    user.id = doc.id;
    state = [...state, user];
  }

  Future<void> edit(LibraryUser user) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        user.id!, user.toMap(), FirestoreCollection.libraryUser);
    state = [
      for (final us in state)
        if (user.id == us.id) user else us,
    ];
  }

  Future<void> remove(LibraryUser user) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(user.id!, FirestoreCollection.libraryUser);
    state = [
      for (final us in state)
        if (us.id != user.id) us
    ];
  }
}
