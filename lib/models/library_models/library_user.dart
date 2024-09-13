import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LibraryUser {
  String? id;
  String name;
  String email;
  String cc;
  DateTime birthday;
  String address;
  String mobile;
  String phone;
  DateTime? registrationDate;

  LibraryUser({
    this.id,
    required this.name,
    required this.email,
    required this.cc,
    required this.birthday,
    required this.address,
    required this.mobile,
    required this.phone,
    required this.registrationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cc': cc,
      'birthday': birthday.millisecondsSinceEpoch,
      'address': address,
      'mobile': mobile,
      'phone': phone,
      'registerDate': registrationDate?.millisecondsSinceEpoch,
    };
  }

  factory LibraryUser.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return LibraryUser(
      id: doc.id ?? "",
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      cc: data['cc'] ?? '',
      birthday: DateTime.fromMillisecondsSinceEpoch(data['birthday']),
      address: data['address'] ?? '',
      mobile: data['mobile'] ?? '',
      phone: data['phone'] ?? '',
      registrationDate:
          DateTime.fromMillisecondsSinceEpoch(data['registerDate']),
    );
  }

  factory LibraryUser.fromMap(Map<String, dynamic> map) {
    return LibraryUser(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      cc: map['cc'] ?? '',
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday']),
      address: map['address'] ?? '',
      mobile: map['mobile'] ?? '',
      phone: map['phone'] ?? '',
      registrationDate:
          DateTime.fromMillisecondsSinceEpoch(map['registerDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryUser.fromJson(String source) =>
      LibraryUser.fromMap(json.decode(source));
}
