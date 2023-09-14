import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  Timestamp? createdAT;

  User({
    required this.uid,
    this.createdAT,
  });
}
