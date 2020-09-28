import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klik_pijaca_admin_app/models/order.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(
    String userId,
    String id,
    String description,
    String status,
    int totalPrice,
    List cart,
  ) {
    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "cart": cart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status,
    });
  }

  Future<List<OrderModel>> getOrders() async =>
      _firestore.collection(collection).get().then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapShot(order));
        }
        print("NUMBER OF ORDERS" + orders.length.toString());
        return orders;
      });
}
