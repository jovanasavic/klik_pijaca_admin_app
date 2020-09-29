import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klik_pijaca_admin_app/models/cart_item.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String _id;
  String _description;
  String _userId;
  String _status;
  int _total;
  int _createdAt;

  //getters
  String get id => _id;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;

  //public variables
  List<CartItemModel> cart;

  OrderModel.fromSnapShot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _description = snapshot.data()[DESCRIPTION];
    _userId = snapshot.data()[USER_ID];
    _status = snapshot.data()[STATUS];
    _total = snapshot.data()[TOTAL];
    _createdAt = snapshot.data()[CREATED_AT];
    cart = convertedCartItems(snapshot.data()[CART], _createdAt);
  }

  List<CartItemModel> convertedCartItems(List cart, int createdAt) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem, createdAt));
    }
    return convertedCart;
  }
}
