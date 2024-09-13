import 'package:ccv_manager/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum FirestoreCollection {
  users,
  events,
  devilCostumes,
  library,
  libraryUser,
  visitors,
  tickets,
  shifts,
  offDays,
  todo,
  suggestions,
  notifications,
  hostelReservations,
}

class FirestoreService {
  Future add(Map<String, dynamic> data, FirestoreCollection collection) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(Constants.firestoreToString[collection]!);
    var doc = await collectionReference.add(data);
    return doc;
  }

  Future<void> update(String id, Map<String, dynamic> data,
      FirestoreCollection collection) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(Constants.firestoreToString[collection]!);
    await collectionReference.doc(id).update(data);
  }

  Future<void> delete(String id, FirestoreCollection collection) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(Constants.firestoreToString[collection]!);
    await collectionReference.doc(id).delete();
  }

  Future get(String id, FirestoreCollection collection) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(Constants.firestoreToString[collection]!);
    final doc = await collectionReference.get();
    return doc;
  }

  Future<QuerySnapshot> getAll(FirestoreCollection collection) async {
    // CollectionReference collectionReference = FirebaseFirestore.instance
    //     .collection(Constants.firestoreToString[collection]!);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var v = Constants.firestoreToString[collection]!;
    print("collection: $v");
    var val = await firestore.collection(v).get();

    return val;
  }

  //   final doc = await collectionReference.get();

  //   List list = [];

  //   for (var element in [doc]) {
  //     //TODO: Check this
  //     list.add(element);
  //   }
  //   return list;
  // }
}
