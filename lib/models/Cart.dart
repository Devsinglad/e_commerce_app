



class UserCart {
  List<CartEntry> userCarts;

  UserCart({required this.userCarts});

  factory UserCart.fromJson(List<dynamic> json) {
    List<CartEntry> userCarts = List<CartEntry>.from(
      json.map((cartEntryJson) => CartEntry.fromJson(cartEntryJson)),
    );

    return UserCart(userCarts: userCarts);
  }
}

class CartEntry {
  int id;
  int userId;
  String date;
  List<ProductEntry> products;
  int v;

  CartEntry({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory CartEntry.fromJson(Map<String, dynamic> json) {
    List<ProductEntry> products = List<ProductEntry>.from(
      json['products'].map((productEntryJson) => ProductEntry.fromJson(productEntryJson)),
    );

    return CartEntry(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: products,
      v: json['__v'],
    );
  }
}

class ProductEntry {
  int productId;
  int quantity;

  ProductEntry({required this.productId, required this.quantity});

  factory ProductEntry.fromJson(Map<String, dynamic> json) {
    return ProductEntry(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}