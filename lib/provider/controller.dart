import 'package:flutter/material.dart';

import '../models/product_category.dart';

class AppControllers extends ChangeNotifier {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  TextEditingController get userNameController => _userNameController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  TextEditingController get cityController => _cityController;


  List<ProductsInEachCat> favoriteProducts = [];

  bool isFavorite(int productId) {
    return favoriteProducts.any((product) => product.id == productId);
  }

  void toggleFavorite({required ProductsInEachCat product}) {
    if (isFavorite(product.id)) {
      favoriteProducts.removeWhere((favoriteProduct) => favoriteProduct.id == product.id);
    } else {
      favoriteProducts.add(product);
    }

    notifyListeners();
  }
}