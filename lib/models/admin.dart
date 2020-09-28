import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";

  String _id;
  String _name;
  String _email;

  //getters
  String get id => _id;
  String get name => _name;
  String get email => _email;

  AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
  }
}
