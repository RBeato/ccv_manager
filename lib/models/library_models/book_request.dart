import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/constants.dart';
import 'book.dart';

class BookRequest {
  String? id;
  String userId;
  String userName;
  List<Book> books;
  RequisitionStatus status;
  DateTime requestDate;
  DateTime deliveryDateLimit;
  DateTime? deliveryDate;
  bool? renewed;
  String? observations;
  EventType eventType;

  BookRequest({
    this.id,
    required this.userId,
    required this.userName,
    required this.books,
    this.status = RequisitionStatus.toBeDelivered,
    required this.requestDate,
    required this.deliveryDateLimit,
    this.eventType = EventType.bookRequest,
    this.deliveryDate,
    this.renewed,
    this.observations,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'books': books.map((x) => x.toMap()).toList(),
      'status': status.toString(),
      'requestDate': requestDate.toString(),
      'deliveryDateLimit': deliveryDateLimit.toString(),
      'deliveryDate': deliveryDate?.toString(),
      'renewed': renewed,
      'observations': observations,
      'eventType': eventType.toString(),
    };
  }

  factory BookRequest.fromMap(Map<String, dynamic> map) {
    return BookRequest(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      books: List<Book>.from(map['books']?.map((x) => Book.fromMap(x))),
      status: RequisitionStatus.values
          .firstWhere((element) => element == map['status']),
      requestDate: DateTime.parse(map['requestDate']),
      deliveryDateLimit: DateTime.parse(map['deliveryDateLimit']),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
      renewed: map['renewed'],
      observations: map['observations'],
      eventType: EventType.bookRequest,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookRequest.fromJson(String source) =>
      BookRequest.fromMap(json.decode(source));

  factory BookRequest.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BookRequest(
      id: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      books: List<Book>.from(data['books']?.map((x) => Book.fromMap(x))),
      status: RequisitionStatus.values
          .firstWhere((element) => element.toString() == data['status']),
      requestDate: DateTime.parse(data['requestDate']),
      deliveryDateLimit: DateTime.parse(data['deliveryDateLimit']),
      deliveryDate: data['deliveryDate'] != null
          ? DateTime.parse(data['deliveryDate'])
          : null,
      renewed: data['renewed'],
      observations: data['observations'],
      eventType: EventType.bookRequest,
    );
  }

  BookRequest copyWith({
    String? id,
    String? userId,
    String? userName,
    List<Book>? books,
    RequisitionStatus? status,
    DateTime? requestDate,
    DateTime? deliveryDateLimit,
    DateTime? deliveryDate,
    bool? renewed,
    String? observations,
  }) {
    return BookRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      books: books ?? this.books,
      status: status ?? this.status,
      requestDate: requestDate ?? this.requestDate,
      deliveryDateLimit: deliveryDateLimit ?? this.deliveryDateLimit,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      renewed: renewed ?? this.renewed,
      observations: observations ?? this.observations,
    );
  }
}

enum RequisitionStatus {
  toBeDelivered,
  delivered,
}
