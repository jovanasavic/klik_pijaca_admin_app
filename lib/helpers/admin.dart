import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klik_pijaca_admin_app/models/admin.dart';

class AdminServices {
  String collection = "admins";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createAdmin(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).doc(id).set(values);
  }

  void updateAdminData(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values['id']).update(values);
  }

  Future<AdminModel> getAdminById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return AdminModel.fromSnapshot(doc);
      });
}
