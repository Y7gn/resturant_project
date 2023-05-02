import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as devtools show log;

import '../model/CartModel.dart';

class Cart with ChangeNotifier {
  var userId;
  Map<String, CartItem> _items = {};
  int totalqty = 0;
  Map<String, CartItem> get items {
    return {..._items};
  }

  void cartUser(id) {
    userId = id;
    // notifyListeners();
  }

  void getItems() async {
    QuerySnapshot newItems = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Cart")
        .get();

    for (var i = 0; i < newItems.docs.length; i++) {
      _items.values.toList()[i].id = newItems.docs[i].id;
      _items.values.toList()[i].title = newItems.docs[i]["title"];
      _items.values.toList()[i].price = newItems.docs[i]["price"];
      _items.values.toList()[i].qty = newItems.docs[i]["quantity"];
      _items.values.toList()[i].price = newItems.docs[i]["price"];
    }
    print(_items);
  }

  // _items.values.toSet().add(CartItem(id: newItems.docs[i].id, title: newItems.docs[i]["title"], price: newItems.docs[i]["price"], qty: newItems.docs[i]["quantity"], image: newItems.docs[i]["image"]));

  void addItem(
      {required String productId, price, title, name, image, quantity}) {
    totalqty++;

    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          price: value.price,
          image: value.image,
          qty: value.qty! + 1,
        ),
      );

      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("Cart")
          .doc(productId)
          .set({
        "quantity": FieldValue.increment(1),
      }, SetOptions(merge: true));
      notifyListeners();
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: productId,
                title: title.toString(),
                price: price.toString(),
                image: image,
                qty: 1,
              ));

      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("Cart")
          .doc(productId)
          .set({
        "id": productId,
        "title": title,
        "price": price,
        "image": image,
        "quantity": 1,
      });

      notifyListeners();
    }
  }

  void removeItemCart(String productId) {
    totalqty--;
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              image: value.image,
              qty: value.qty! - 1));

      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("Cart")
          .doc(productId)
          .get()
          .then(
        (doc) {
          if (doc.exists && doc.data()!["quantity"] == 0) {
            doc.reference.delete();
          }
        },
      );

      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("Cart")
          .doc(productId)
          .set({
        "quantity": FieldValue.increment(-1),
      }, SetOptions(merge: true));

      notifyListeners();
    }
  }

  void clearCart() {
    totalqty = 0;
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Cart")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    _items.clear();
    notifyListeners();
  }

  void removeCart(item) {
    _items.remove(item);
    notifyListeners();
  }

  double get totalToPay {
    double total = 0.0;
    _items.forEach((key, value) {
      total += double.parse(value.price!) * value.qty!;
    });
    return total;
  }
}
