import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik_pijaca_admin_app/helpers/product.dart';
import 'package:klik_pijaca_admin_app/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsSearched = [];
  bool featured = false;

  ProductModel _productModel;

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  File productImage;
  final picker = ImagePicker();
  String productImageFileName;

  ProductProvider.initialize() {
    loadProducts();
    search();
  }

  loadProducts() async {
    products = await _productsServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory =
        await _productsServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future<bool> uploadProduct({String category}) async {
    try {
      String id = Uuid().v1();
      String imageUrl = await _uploadImageFile(
          imageFile: productImage, imageFileName: productImageFileName);
      Map data = {
        "id": id,
        "name": name.text.trim(),
        "image": imageUrl,
        "rates": 0,
        "rating": 0.0,
        "price": double.parse(price.text.trim()),
        "description": description.text.trim(),
        "featured": featured,
        "category": category
      };
      _productsServices.createProduct(data: data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  changeFeatured() {
    featured = !featured;
    notifyListeners();
  }

// method to load image files
  getImageFile({ImageSource source}) async {
    final pickedFile =
        await picker.getImage(source: source, maxWidth: 640, maxHeight: 400);
    productImage = File(pickedFile.path);
    productImageFileName =
        productImage.path.substring(productImage.path.indexOf('/') + 1);
    notifyListeners();
  }

  // method to upload the file to firebase
  Future _uploadImageFile({File imageFile, String imageFileName}) async {
    StorageReference reference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return imageUrl;
  }

  Future search({String productName}) async {
    productsSearched =
        await _productsServices.serchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS:" +
        productsSearched.length.toString());
    notifyListeners();
  }

  clear() {
    productImage = null;
    productImageFileName = null;
    name = null;
    description = null;
    price = null;
  }
}
