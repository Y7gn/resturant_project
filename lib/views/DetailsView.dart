import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as devtools show log;
import 'package:badges/badges.dart' as badges;
// import 'package:myproject/main.dart';
// import 'package:myproject/model/ProductsModel.dart';
// import 'package:myproject/model/cartModel.dart';
// import 'package:myproject/providers/cart_provider.dart';

// import 'package:myproject/utils/color_utils.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/color_utils.dart';

class DetailsView extends StatefulWidget {
  final String id;

  /// Constructs a [DetailsScreen]
  const DetailsView({super.key, required this.id});
  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  var urlImage;
  var description;
  var price;
  var title;
  late String id = widget.id;
  int? qty;

  getProductInfo(id, cart) async {
    var productRef = await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .get()
        .then((doc) => {
              urlImage = doc.get("urlImage"),
              description = doc.get("description"),
              price = doc.get("price"),
              title = doc.get("title"),
            });

    cart.items.forEach((key, value) {
      if (value.id == id) {
        qty = value.qty ??= 0;
      }
      if (value.id == null) {
        qty = 0;
      }
    });
    return productRef;
  }

  @override
  void initState() {
    super.initState();
  }

  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  // List<CartModel> cartModels = new List<CartModel>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items;
    return FutureBuilder(
        future: getProductInfo(widget.id, cart),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text('Product Details',
                    style: TextStyle(color: Colors.black)),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: BackButton(
                  color: Colors.black,
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      context.push("/cart");
                    },
                    child: Center(
                      child: badges.Badge(
                        badgeContent: Text("${cart.totalqty.toString()}"),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20)

                  // Padding(
                  //   padding: EdgeInsets.only(top: 10, right: 20),
                  //   child: Container(
                  //     child: IconButton(
                  //         onPressed: () {

                  //         },
                  //         icon: Icon(Icons.shopping_cart,color: Colors.black,),
                  //     ),
                  //   ),
                  //   // child: StreamBuilder(
                  //   //   stream: FirebaseDatabase.instance.reference().child()
                  //   //   builder: BuildContext context, AsyncSnapshot<Event> snapshot){

                  //   // })

                  //   //   IconButton(
                  //   //       onPressed: () {},
                  //   //
                  //   // )     icon: Icon(Icons.shopping_bag, color: Colors.black),
                  // ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   '${context.watch<Counter>().count}',
                    // ),
                    // Text(
                    //   '${context.watch<Cart>().items}',
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: hexStringToColor("FCFCFC"),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(30, 0, 0, 0),
                                  spreadRadius: 1,
                                  blurRadius: 20,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Image.network(
                              urlImage,
                              fit: BoxFit.fill,
                            ),
                            margin: EdgeInsets.all(
                              20,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: hexStringToColor("FF0036"),
                                borderRadius: BorderRadius.circular(10)),
                            width: 140,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      context.read<Cart>().removeItemCart(id);
                                    },
                                  ),
                                ),
                                Text(
                                  (qty ?? 0).toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24),
                                ),
                                Container(
                                    child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    addToCart(id, price, title, urlImage);
                                  },
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text("$price\$",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("Decription",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(description,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300))
                              ],
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     style: ButtonStyle(
                          //       backgroundColor:
                          //           MaterialStateProperty.all<Color>(
                          //               Colors.black),
                          //     ),
                          //     onPressed: () {

                          //       addToCart(id, price, title, urlImage);
                          //     },
                          //     child: Text("Add to cart"),
                          //   ),
                          // ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              onPressed: () {
                                clearCart();
                                qty = 0;
                              },
                              child: Text("Clear cart"),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              onPressed: () {
                                context.read<Cart>().getItems();
                              },
                              child: Text("GetItems cart"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  void addToCart(id, price, title, urlImage) {
    // print("triggered");

    context.read<Cart>().addItem(
        productId: id, price: price.toString(), title: title, image: urlImage);
    // context.read<Cart>().items;
  }
  // context.read<Counter>().increment();

  // var userId = FirebaseAuth.instance.currentUser?.uid;
  // print(userId);

  // var cart = FirebaseFirestore.instance.collection("users").doc(userId).collection("Cart").doc(id).set({
  //   "quantity":123,
  // });
  void clearCart() {
    context.read<Cart>().clearCart();
  }

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // firestore.collection('cart').doc(drinkModel.key).get().then((DocumentSnapshot snapshot) {
  // void addToCart(GlobalKey<ScaffoldState> scaffoldKey, ProductsModel drinkModel){

  // var cart = FirebaseDatabase.instance.ref().child("Cart").child("Unique_USER_ID");

  // cart.child(drinkModel.key).once().then((value){
  //     if (snapshot.exists) {
  //       // Data found at the specified document path
  //       var cartModel = CartModel.fromJson(json.decode(json.encode(snapshot.value)));
  //       cartModel.quantity+=1;
  //       cartModel.totalPrice = double.parse(drinkModel.price);

  //       // Do something with the data...
  //     } else {
  //       // No data found at the specified document path
  //     }
  //   },
  // );
}
