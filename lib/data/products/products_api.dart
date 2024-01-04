import 'dart:async';
import 'dart:convert';
import 'package:e_commerce_app/utils/helper.dart';
import 'package:flutter/material.dart';
import '../../core/api_const.dart';
import '../../core/base_api.dart';
import '../../core/base_response.dart';
import '../../models/Cart.dart';
import '../../models/Product.dart';
import '../../models/product_category.dart';
import '../../utils/enum.dart';

class ProductApi extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final ApiRoutes _apiRoutes = ApiRoutes();
  ButtonState buttonState = ButtonState.idle;
  List categories = <ProductCategory>[];
  List<ProductsInEachCat> products = [];
  var image;
  var title;
  var price;
  List<Products> userCartItems = [];
  bool initCatPage = false;
  bool initCartPage = false;

  Future<void> getCategories() async {
    initCatPage = true;
    notifyListeners();
    ResponseModel responseModel = await _apiService
        .call(
      method: HttpMethod.get,
      endpoint: '${_apiRoutes.baseUrl}${_apiRoutes.getCategory}',
    )
        .whenComplete(() {
      initCatPage = false;
      notifyListeners();
    });
    print(responseModel.statusCode);
    var decodeData = jsonDecode(responseModel.response.body);
    var data = ProductCategory.fromJson(decodeData);
    categories = data.categories;
    notifyListeners();
  }

  Future<List<ProductsInEachCat>> getCategoriesProducts(categories) async {
    ResponseModel responseModel = await _apiService.call(
      method: HttpMethod.get,
      endpoint: 'https://fakestoreapi.com/products/category/$categories',
    );
    print(responseModel.statusCode);
    if (responseModel.isSuccess) {
      var decodedData = jsonDecode(responseModel.response.body);
      products = (decodedData as List<dynamic>)
          .map((item) => ProductsInEachCat.fromJson(item))
          .toList();

      notifyListeners();
      print('>>>>>>${products.first.rating}');
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> addToCart({
    required List<Map<String, dynamic>> products,
  }) async {
    try {
      buttonState = ButtonState.loading;
      notifyListeners();
      ResponseModel responseModel = await _apiService.call(
        method: HttpMethod.post,
        endpoint: '${_apiRoutes.baseUrl}${_apiRoutes.addToCart}',
        reqBody: {
          "userId": '1',
          "date": "${DateTime.now()}",
          "products": products
        },
      );
      print(responseModel.response.body);
      notifyListeners();
      if (responseModel.isSuccess) {
        toastMessage(text: 'Added to cart');
      }
    } catch (e, s) {
      print(e);
    }
  }

  Future<void> getUserCarts({productId}) async {
    try {
      initCartPage = true;
      ResponseModel responseModel = await _apiService.call(
          method: HttpMethod.get,
          endpoint: 'https://fakestoreapi.com/carts/user/1');

      print('<<<<${responseModel.statusCode}>>>>');

      if (responseModel.isSuccess) {
        var decodedData = jsonDecode(responseModel.response.body);

        if (decodedData is List) {
          userCartItems = [];
          for (var cartData in decodedData) {
            if (cartData is Map<String, dynamic>) {
              var userCart = UserCart.fromJson(cartData);
              userCartItems.addAll(userCart.products ?? []);
            }
          }
        }
         //fetchProductDetailsForCart();
        initCartPage = false;
        notifyListeners();
      } else {
        initCartPage = false;
        notifyListeners();
      }
    } catch (e, s) {
      initCartPage = false;
      notifyListeners();
      throw Exception('Bad Request: $e, $s');
    }
  }

  Future<void> fetchProductDetailsForCart() async {
    for (var product in userCartItems) {
      await getSingleProductDetails(productId: product.productId);
    }
  }

  Future<void> getSingleProductDetails({productId}) async {
    try {
      ResponseModel responseModel = await _apiService
          .call(
              method: HttpMethod.get,
              endpoint: 'https://fakestoreapi.com/products/$productId')
          .timeout(const Duration(seconds: 30));
      print('<<<<${responseModel.statusCode}>>>>');
      print(responseModel.response.body);
      if (responseModel.isSuccess) {
        buttonState = ButtonState.success;
        notifyListeners();
        var decodedData = jsonDecode(responseModel.response.body);
        var responseData = SingleProductDetail.fromJson(decodedData);
        price = responseData.price;
        image = responseData.image;
        title= responseData.title;

        print('<<<<<${responseData.image}');
        notifyListeners();
      }
    } on TimeoutException catch (e) {
      toastMessage(text: 'Network TIme out');
      print('Timeout: $e');
    } catch (e, s) {
      throw Exception('Bad Request: $e, $s');
    }
  }

}