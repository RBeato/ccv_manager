import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firedart/firestore/models.dart';

class CCVUser {
  String id;
  String name;
  String email;
  String role;
  String authId;

  CCVUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.authId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'authId': authId,
    };
  }

  factory CCVUser.fromSnapshot(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return CCVUser(
      id: doc.id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      authId: map['authId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CCVUser.fromJson(String source) =>
      CCVUser.fromSnapshot(json.decode(source));

  @override
  String toString() {
    return 'CCVUser(id: $id, name: $name, email: $email, role: $role, authId: $authId)';
  }
}
