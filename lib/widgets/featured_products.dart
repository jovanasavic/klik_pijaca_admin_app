import 'package:flutter/material.dart';
import 'package:klik_pijaca_admin_app/helpers/screen_navigation.dart';
import 'package:klik_pijaca_admin_app/helpers/style.dart';
import 'package:klik_pijaca_admin_app/providers/product.dart';
import 'package:klik_pijaca_admin_app/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
        // height: 220,
        // child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: productProvider.products.length,
        //     itemBuilder: (_, index) {
        //       return Padding(
        //           padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
        //           child: GestureDetector(
        //             onTap: () {
        //               changeScreen(
        //                   _,
        //                   Details(
        //                     product: productProvider.products[index],
        //                   ));
        //             },
        //             child: Container(
        //               height: 220,
        //               width: 200,
        //               decoration: BoxDecoration(
        //                   color: white,
        //                   borderRadius: BorderRadius.circular(20),
        //                   boxShadow: [
        //                     BoxShadow(
        //                         color: Colors.grey[300],
        //                         offset: Offset(-2, -1),
        //                         blurRadius: 5),
        //                   ]),
        //               child: Column(
        //                 children: <Widget>[
        //                   ClipRRect(
        //                     borderRadius: BorderRadius.only(
        //                         topLeft: Radius.circular(20),
        //                         topRight: Radius.circular(20)),
        //                     child: Stack(
        //                       children: <Widget>[
        //                         Positioned.fill(
        //                             child: Align(
        //                           alignment: Alignment.center,
        //                           child: Loading(),
        //                         )),
        //                         Center(
        //                           child: FadeInImage.memoryNetwork(
        //                             placeholder: kTransparentImage,
        //                             image: productProvider.products[index].image,
        //                             height: 126,
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: <Widget>[
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: CustomText(
        //                           text: productProvider.products[index].name ??
        //                               "id null",
        //                         ),
        //                       ),
        //                       Padding(
        //                         padding: EdgeInsets.all(8),
        //                         child: Container(
        //                           decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(20),
        //                               color: white,
        //                               boxShadow: [
        //                                 BoxShadow(
        //                                     color: Colors.grey[300],
        //                                     offset: Offset(1, 1),
        //                                     blurRadius: 4),
        //                               ]),
        //                           child: Padding(
        //                             padding: const EdgeInsets.all(4.0),
        //                             child: Icon(
        //                               Icons.favorite_border,
        //                               color: green,
        //                               size: 18,
        //                             ),
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: <Widget>[
        //                       Row(
        //                         children: <Widget>[
        //                           Padding(
        //                             padding: const EdgeInsets.only(left: 8.0),
        //                             child: CustomText(
        //                               text: productProvider.products[index].rating
        //                                   .toString(),
        //                               color: grey,
        //                               size: 14.0,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 2,
        //                           ),
        //                           Icon(
        //                             Icons.star,
        //                             color: green,
        //                             size: 16,
        //                           ),
        //                           Icon(
        //                             Icons.star,
        //                             color: green,
        //                             size: 16,
        //                           ),
        //                           Icon(
        //                             Icons.star,
        //                             color: green,
        //                             size: 16,
        //                           ),
        //                           Icon(
        //                             Icons.star,
        //                             color: grey,
        //                             size: 16,
        //                           ),
        //                         ],
        //                       ),
        //                       Padding(
        //                         padding: const EdgeInsets.only(right: 8.0),
        //                         child: CustomText(
        //                           text: "rsd" +
        //                               productProvider.products[index].price
        //                                   .toString(),
        //                           weight: FontWeight.bold,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ));
        //     }),
        );
  }
}
