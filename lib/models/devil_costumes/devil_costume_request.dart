import 'dart:convert';

// import 'package:firedart/firedart.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/constants.dart';
import '../library_models/book_request.dart';
import 'devil_costume.dart';

class DevilCostumeRequest {
  String? id;
  String name;
  String address;
  int phoneNumber;
  DateTime? requestDate;
  DateTime? deliveryDateLimit;
  DateTime? deliveryDate;
  EventType eventType = EventType.devilCostume;
  List<DevilCostume> costumes;
  DevilCustomUsage devilCostumeRequestType;
  RequisitionStatus? status;

  DevilCostumeRequest({
    this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    this.requestDate,
    this.deliveryDateLimit,
    required this.devilCostumeRequestType,
    this.deliveryDate,
    this.eventType = EventType.devilCostume,
    this.status,
    required this.costumes,
  });

  @override
  String toString() {
    return 'DevilCostumeRequest(name: $name, address: $address, phoneNumber: $phoneNumber, requestDate: $requestDate, deliveryDateLimit: $deliveryDateLimit, deliveryDate: $deliveryDate, costumes: $costumes)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'requestDate': requestDate?.toString() ?? '',
      'deliveryDateLimit': deliveryDateLimit?.toString() ?? '',
      'devilCostumeRequestType': devilCostumeRequestType.toString(),
      'deliveryDate': deliveryDate?.toString(),
      'eventType': eventType.toString(),
      'costumes': costumes.map((x) => x.toMap()).toList(),
      'status': status?.toString(),
    };
  }

  factory DevilCostumeRequest.fromMap(Map<String, dynamic> map) {
    return DevilCostumeRequest(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      requestDate: DateTime.parse(map['requestDate']),
      deliveryDateLimit: DateTime.parse(map['deliveryDateLimit']),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
      devilCostumeRequestType: DevilCustomUsage.values
          .firstWhere((element) => element == map['usage']),
      costumes: List<DevilCostume>.from(
          map['costumes']?.map((x) => DevilCostume.fromMap(x))),
      status: RequisitionStatus.values
          .firstWhere((element) => element == map['status']),
      eventType: EventType.values
          .firstWhere((element) => element.toString() == map['eventType']),
    );
  }

  factory DevilCostumeRequest.fromSnapshot(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    return DevilCostumeRequest(
      id: doc.id,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      requestDate: DateTime.parse(map['requestDate']),
      devilCostumeRequestType: DevilCustomUsage.values.firstWhere(
          (element) => element.toString() == map['devilCostumeRequestType']),
      deliveryDateLimit: DateTime.parse(map['deliveryDateLimit']),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
      costumes: List<DevilCostume>.from(
          map['costumes']?.map((x) => DevilCostume.fromMap(x))),
      status: RequisitionStatus.values
          .firstWhere((element) => element.toString() == map['status']),
      eventType: EventType.values
          .firstWhere((element) => element.toString() == map['eventType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DevilCostumeRequest.fromJson(String source) =>
      DevilCostumeRequest.fromMap(json.decode(source));

  DevilCostumeRequest copyWith({
    String? id,
    String? name,
    String? address,
    int? phoneNumber,
    DateTime? requestDate,
    DateTime? deliveryDateLimit,
    DateTime? deliveryDate,
    List<DevilCostume>? costumes,
    DevilCustomUsage? devilCostumeRequestType,
    RequisitionStatus? status,
  }) {
    return DevilCostumeRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      requestDate: requestDate ?? this.requestDate,
      deliveryDateLimit: deliveryDateLimit ?? this.deliveryDateLimit,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      costumes: costumes ?? this.costumes,
      devilCostumeRequestType:
          devilCostumeRequestType ?? this.devilCostumeRequestType,
      status: status ?? this.status,
    );
  }
}
