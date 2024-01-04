
class UserCart {
  dynamic id;
  dynamic userId;
  dynamic date;
  List<Products>? products;
  dynamic iV;

  UserCart({this.id, this.userId, this.date, this.products, this.iV});

  UserCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];

    if (json['products'] != null && json['products'] is List) {
      products = <Products>[];
      for (var productData in json['products']) {
        if (productData is Map<String, dynamic>) {
          products!.add(Products.fromJson(productData));
        }
      }
    }

    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;

    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }

    data['__v'] = iV;
    return data;
  }
}

class Products {
  dynamic productId;
  dynamic quantity;

  Products({this.productId, this.quantity});

  Products.fromJson(dynamic json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}