class CartItem {
  String? id;
  String? title;
  String? price;
  int? qty;
  String? image;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.qty,
    required this.image,
  });

  // CartItem.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'];
  //   image = json['image'];
  //   price = json['price'];
  //   qty = json['qty'] as int;
  //   // totalprice = double.parse(json['totalprice']);
  // }

  // Map<String,dynamic> toJson(){
  //   final Map<String,dynamic> data = new Map<String,CartItem>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['image'] = this.image;
  //   data['price'] = this.price;
  //   data['qty'] = this.qty;
  //   // data['totalprice'] = this.totalprice;

  //   return data;
  // }

  
}



// class CartModel {
//   String? key;
//   String? title;
//   String? image;
//   String? price;
//   int? qty;
//   double? totalprice;

//   CartModel(
//       {required this.key,
//       required this.title,
//       required this.image,
//       required this.price,
//       required this.qty,
//       required this.totalprice});

//   CartModel.fromJson(Map<String, dynamic> json) {
//     key = json['key'];
//     title = json['title'];
//     image = json['image'];
//     price = json['price'];
//     qty = json['qty'] as int;
//     totalprice = double.parse(json['totalprice']);
//   }

//   Map<String,dynamic> toJson(){
//     final Map<String,dynamic> data = new Map<String,dynamic>();
//     data['key'] = this.key;
//     data['title'] = this.title;
//     data['image'] = this.image;
//     data['price'] = this.price;
//     data['qty'] = this.qty;
//     data['totalprice'] = this.totalprice;

//     return data;
//   }

// }
