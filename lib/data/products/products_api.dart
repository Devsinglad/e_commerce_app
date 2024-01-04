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

  //UserCart? cartData;
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
          // Assuming the response is a list of carts
          userCartItems = [];
          for (var cartData in decodedData) {
            if (cartData is Map<String, dynamic>) {
              var userCart = UserCart.fromJson(cartData);
              userCartItems.addAll(userCart.products ?? []);
            }
          }
        }

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
      print(product.productId);
      //await getSingleProductDetails(productId: product.productId);
    }
  }

  Future<void> getSingleProductDetails({productId}) async {
    try {
      buttonState = ButtonState.loading;
      ResponseModel responseModel = await _apiService
          .call(
              method: HttpMethod.get,
              endpoint: 'https://fakestoreapi.com/products/$productId')
          .timeout(Duration(seconds: 10));
      print('<<<<${responseModel.statusCode}>>>>');
      print(responseModel.response.body);
      if (responseModel.isSuccess) {
        buttonState = ButtonState.success;
        notifyListeners();
        var decodedData = jsonDecode(responseModel.response.body);
        var responseData = SingleProductDetail.fromJson(decodedData);
        price = responseData.price;
        print('<<<<<$decodedData');
        print('<<<<<${responseData.image}');
        notifyListeners();
      } else {
        buttonState = ButtonState.idle;
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