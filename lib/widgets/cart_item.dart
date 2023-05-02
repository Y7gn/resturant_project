import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile(
      {super.key,
      required this.image,
      required this.id,
      required this.title,
      required this.productId,
      required this.price,
      required this.qty});

  final String id;
  final String title;
  final String productId;
  final String price;
  final int qty;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Image?.network(image),
        // leading: Text(price.toString()),
        title: Text(title.toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("x${qty.toString()}"),
            Text("x${double.parse(price) * qty}")
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.black,
          ),
          onPressed: () {
            Provider.of<Cart>(context, listen: false).removeCart(productId);
          },
        ),
      ),
    );
  }
  // void removeCart(id) {
  //     context.read<Cart>().removeCart(id);
  //   }
}
