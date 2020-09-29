import 'package:flutter/material.dart';
import 'package:klik_pijaca_admin_app/providers/admin.dart';
import 'package:provider/provider.dart';
import 'package:klik_pijaca_admin_app/models/cart_item.dart';
import 'package:klik_pijaca_admin_app/widgets/custom_text.dart';
import 'package:klik_pijaca_admin_app/helpers/style.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
          text: "Orders",
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
      body: ListView.builder(
          itemCount: adminProvider.cartItems.length,
          itemBuilder: (_, index) {
            List<CartItemModel> cart = adminProvider.cartItems;
            return ListTile(
              leading: CustomText(
                text: "RSD" + cart[index].totalSales.toString(),
                weight: FontWeight.bold,
              ),
              title: Text(cart[index].name),
              subtitle: Text(
                  DateTime.fromMillisecondsSinceEpoch(cart[index].date)
                      .toString()),
            );
          }),
    );
  }
}
