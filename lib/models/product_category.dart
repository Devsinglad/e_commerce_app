class ProductCategory {
  List<String> categories;

  ProductCategory({required this.categories});

  factory ProductCategory.fromJson(List<dynamic> json) {
    return ProductCategory(
      categories: List<String>.from(json),
    );
  }
}


class ProductsInEachCat {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductsInEachCat({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductsInEachCat.fromJson(Map<String, dynamic> json) {
    return ProductsInEachCat(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
}