import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_admin_app/helpers/order.dart';
import 'package:klik_pijaca_admin_app/helpers/admin.dart';
import 'package:klik_pijaca_admin_app/models/order.dart';
import 'package:klik_pijaca_admin_app/models/product.dart';
import 'package:klik_pijaca_admin_app/models/admin.dart';
import 'package:klik_pijaca_admin_app/models/cart_item.dart';

import 'package:klik_pijaca_admin_app/helpers/product.dart';

import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AdminProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AdminServices _userServicse = AdminServices();
  OrderServices _orderServices = OrderServices();
  AdminModel _adminModel;

  ProductsServices _productServices = ProductsServices();
  List<ProductModel> products = <ProductModel>[];

  int _totalSales = 0;

//  getter
  AdminModel get adminModel => _adminModel;
  Status get status => _status;
  User get user => _user;
  int get totalSales => _totalSales;

  //public variable

  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  AdminProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('admins').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadAdminModel() async {
    _adminModel = await _userServicse.getAdminById(user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      await loadAllProducts();
      await getOrders();
      await getTotalSales();
      _adminModel = await _userServicse.getAdminById(user.uid);
    }
    notifyListeners();
  }

  Future loadAllProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  getOrders() async {
    orders = await _orderServices.getOrders();
    notifyListeners();
  }

  getTotalSales() async {
    for (OrderModel order in orders) {
      // for (CartItemModel item in order.cart) {
      _totalSales = _totalSales + order.total;
      // }
    }
    print("TOTAL SALES!!!!!!" + _totalSales.toString());
    notifyListeners();
  }
}
