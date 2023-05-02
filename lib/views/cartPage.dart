import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as devtools show log;

import '../providers/cart_provider.dart';

class cartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    if (cart.isEmpty) return Text('Not found Cards');
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Chip(label: Text("${cart.totalToPay.toString()} \$")),
              Expanded(
                child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) => CartItemTile(
                          id: cart.items.values.toList()[index].id!,
                          title: cart.items.values.toList()[index].title!,
                          price: cart.items.values.toList()[index].price!,
                          qty: cart.items.values.toList()[index].qty!,
                          image: cart.items.values.toList()[index].image!,
                          productId: cart.items.keys.toList()[index],
                        )),
              )
            ],
          ),
        ));
  }
}
