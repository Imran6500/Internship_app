// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullname;
  final String email;
  final String password;

  UserModel({
    required this.fullname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() =>
      {fullname: fullname, email: email, password: password};

  static UserModel? fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      fullname: snapshot['fullname'],
      email: snapshot['email'],
      password: snapshot['password'],
    );
  }
}
