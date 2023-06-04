import 'package:cloud_firestore/cloud_firestore.dart';

class AppUsers {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;

  AppUsers({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
  });
}
