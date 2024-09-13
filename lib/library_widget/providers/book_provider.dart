import 'package:ccv_manager/models/library_models/book_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/firebase_storing.dart';

final bookProvider =
    StateNotifierProvider<BookRequisitionNotifier, List<BookRequest>>((ref) {
  return BookRequisitionNotifier();
});

class BookRequisitionNotifier extends StateNotifier<List<BookRequest>> {
  BookRequisitionNotifier() : super([]) {
    getEvents();
  }

  getEvents() async {
    // final dummyData = DummyLibraryData.reqBooks;
    List<BookRequest> savedRequests = [];
    FirestoreService firestoreService = FirestoreService();

    await firestoreService.getAll(FirestoreCollection.library).then((value) {
      for (var document in value.docs) {
        savedRequests.add(BookRequest.fromSnapshot(document));
      }
    });

    // state = [...dummyData, ...savedRequests];
    state = [...savedRequests];
  }

  Future<void> add(BookRequest bookReq) async {
    FirestoreService firestoreService = FirestoreService();
    var doc = await firestoreService.add(
        bookReq.toMap(), FirestoreCollection.library);
    bookReq.id = doc.id;
    state = [...state, bookReq];
  }

  Future<void> edit(BookRequest bookRequest) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.update(
        bookRequest.id!, bookRequest.toMap(), FirestoreCollection.library);
    state = [
      for (final req in state)
        if (bookRequest.id == req.id) bookRequest else req,
    ];
  }

  Future<void> remove(BookRequest bookRequest) async {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.delete(bookRequest.id!, FirestoreCollection.library);
    state = [
      for (final ev in state)
        if (ev.id != bookRequest.id) ev
    ];
  }
}
