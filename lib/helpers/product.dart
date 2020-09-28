import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klik_pijaca_admin_app/models/product.dart';

class ProductsServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createProduct({Map data}) async {
    _firestore.collection(collection).doc(data['id']).set({
      "id": data['id'],
      "name": data['name'],
      "image": data['image'],
      "rates": data['rates'],
      "rating": data['rating'],
      "price": data['price'],
      "description": data['description'],
      "featured": data['featured'],
      "category": data['category']
    });
  }

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapShot(product));
        }
        print("PRODUCTS" + products.length.toString());
        return products;
      });

  Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapShot(product));
        }
        return products;
      });

  Future<List<ProductModel>> serchProducts({String productName}) {
    String searchKey = productName[0].toLowerCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapShot(product));
          }
          return products;
        });
  }
}
