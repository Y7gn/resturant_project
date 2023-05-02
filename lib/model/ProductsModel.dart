class ProductsModel {
  String? key;
  String? description;
  bool? featured;
  int? price;
  String? title;
  String? urlImage;

  ProductsModel(
      {this.key,this.description, this.featured, this.price, this.title, this.urlImage});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    description = json['description'];
    featured = json['featured'];
    price = json['price'];
    title = json['title'];
    urlImage = json['urlImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['featured'] = this.featured;
    data['price'] = this.price;
    data['title'] = this.title;
    data['urlImage'] = this.urlImage;
    return data;
  }
}