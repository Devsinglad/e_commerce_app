//
//
//
//
// class UserCart {
//   List<CartEntry> userCarts;
//
//   UserCart({required this.userCarts});
//
//   factory UserCart.fromJson(List<dynamic> json) {
//     List<CartEntry> userCarts = List<CartEntry>.from(
//       json.map((cartEntryJson) => CartEntry.fromJson(cartEntryJson)),
//     );
//
//     return UserCart(userCarts: userCarts);
//   }
// }
//
// class CartEntry {
//   int id;
//   int userId;
//   String date;
//   List<ProductEntry> products;
//   int v;
//
//   CartEntry({
//     required this.id,
//     required this.userId,
//     required this.date,
//     required this.products,
//     required this.v,
//   });
//
//   factory CartEntry.fromJson(Map<String, dynamic> json) {
//     List<ProductEntry> products = List<ProductEntry>.from(
//       json['products'].map((productEntryJson) => ProductEntry.fromJson(productEntryJson)),
//     );
//
//     return CartEntry(
//       id: json['id'],
//       userId: json['userId'],
//       date: json['date'],
//       products: products,
//       v: json['__v'],
//     );
//   }
// }
//
// class ProductEntry {
//   int productId;
//   int quantity;
//
//   ProductEntry({required this.productId, required this.quantity});
//
//   factory ProductEntry.fromJson(Map<String, dynamic> json) {
//     return ProductEntry(
//       productId: json['productId'],
//       quantity: json['quantity'],
//     );
//   }
// }

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