import 'package:flutter/material.dart';
import 'package:klik_pijaca_admin_app/widgets/custom_text.dart';
import 'package:klik_pijaca_admin_app/helpers/style.dart';
import 'package:provider/provider.dart';
import 'package:klik_pijaca_admin_app/widgets/product.dart';

import 'package:klik_pijaca_admin_app/providers/admin.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Products",
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(Icons.add_shopping_cart,
                            color: black, size: 30),
                        onPressed: () {})),
                Positioned(
                  right: 10,
                  bottom: 2,
                  child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: grey,
                                offset: Offset(2, 3),
                                blurRadius: 3)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: CustomText(
                          text: "2",
                          color: green,
                          size: 17,
                          weight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: adminProvider.products
            .map((item) => GestureDetector(
                  onTap: () {
                    // changeScreen(
                    //     context,
                    //     Details(
                    //       product: item,
                    //     ));
                  },
                  child: ProductWidget(
                    product: item,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
