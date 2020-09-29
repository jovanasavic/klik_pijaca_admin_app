import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik_pijaca_admin_app/helpers/style.dart';
import 'package:klik_pijaca_admin_app/providers/category.dart';
import 'package:klik_pijaca_admin_app/providers/product.dart';
import 'package:klik_pijaca_admin_app/providers/app.dart';
import 'package:klik_pijaca_admin_app/widgets/loading.dart';
import 'package:klik_pijaca_admin_app/providers/admin.dart';
import 'package:klik_pijaca_admin_app/widgets/custom_file_button.dart';
import 'package:klik_pijaca_admin_app/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final itemProvider = Provider.of<ItemsProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: white,
          title: Text(
            "Add Product",
            style: TextStyle(color: black),
          )),
      body: app.isLoading
          ? Loading()
          : ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: productProvider?.productImage == null
                            ? CustomFileUploadButton(
                                icon: Icons.image,
                                text: "Add image",
                                onTap: () async {
                                  //productProvider.loadImageFile();
                                  return showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return Container(
                                          child: new Wrap(
                                            children: <Widget>[
                                              new ListTile(
                                                  leading:
                                                      new Icon(Icons.image),
                                                  title:
                                                      new Text('From gallery'),
                                                  onTap: () async {
                                                    productProvider
                                                        .getImageFile(
                                                            source: ImageSource
                                                                .gallery);
                                                    Navigator.pop(context);
                                                  }),
                                              new ListTile(
                                                leading:
                                                    new Icon(Icons.camera_alt),
                                                title: new Text('Take a photo'),
                                                onTap: () async {
                                                  productProvider.getImageFile(
                                                      source:
                                                          ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                })
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:
                                    Image.file(productProvider.productImage)),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: productProvider.productImage != null,
                  child: FlatButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                      leading: new Icon(Icons.image),
                                      title: new Text('From gallery'),
                                      onTap: () async {
                                        productProvider.getImageFile(
                                            source: ImageSource.gallery);
                                        Navigator.pop(context);
                                      }),
                                  new ListTile(
                                    leading: new Icon(Icons.camera_alt),
                                    title: new Text('Take a photo'),
                                    onTap: () async {
                                      productProvider.getImageFile(
                                          source: ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "change image",
                      color: green,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomText(text: "featured"),
                        Switch(
                            value: productProvider.featured,
                            onChanged: (value) {
                              productProvider.changeFeatured();
                            })
                      ],
                    )),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomText(
                      text: "Category:",
                      color: grey,
                      weight: FontWeight.w300,
                    ),
                    DropdownButton<String>(
                      value: categoryProvider.selectedCategory,
                      style:
                          TextStyle(color: green, fontWeight: FontWeight.w300),
                      icon: Icon(
                        Icons.filter_list,
                        color: green,
                      ),
                      elevation: 0,
                      onChanged: (value) {
                        categoryProvider.changeSelectedCategory(
                            newCategory: value.trim());
                      },
                      items: categoryProvider.categoriesNames
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.name,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Product name",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.description,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Product description",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Price",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                      decoration: BoxDecoration(
                          color: green,
                          border: Border.all(color: black, width: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: grey.withOpacity(0.3),
                                offset: Offset(2, 7),
                                blurRadius: 4)
                          ]),
                      child: FlatButton(
                        onPressed: () async {
                          app.changeLoadingState();
                          if (!await productProvider.uploadProduct(
                            category: categoryProvider.selectedCategory,
                          )) {
                            _key.currentState.showSnackBar(SnackBar(
                              content: Text("Upload Failed"),
                              duration: const Duration(seconds: 10),
                            ));
                            app.changeLoadingState();
                            return;
                          }
                          // else {
                          productProvider.clear();
                          //  itemProvider.getItems();
                          _key.currentState.showSnackBar(SnackBar(
                            content: Text("Upload completed"),
                            duration: const Duration(seconds: 10),
                          ));
                          adminProvider.loadAllProducts();
                          adminProvider.reloadAdminModel();
                          app.changeLoadingState();
                          return;
                          // }
                        },
                        child: CustomText(
                          text: "Post",
                          color: white,
                        ),
                      )),
                ),
              ],
            ),
    );
  }
}
