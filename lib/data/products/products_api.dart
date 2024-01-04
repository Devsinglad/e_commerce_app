import 'dart:convert';
import 'package:e_commerce_app/utils/helper.dart';
import 'package:flutter/material.dart';
import '../../core/api_const.dart';
import '../../core/base_api.dart';
import '../../core/base_response.dart';
import '../../models/Cart.dart';
import '../../models/Product.dart';
import '../../models/product_category.dart';
import '../../provider/controller.dart';
import '../../utils/enum.dart';

class ProductApi extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final ApiRoutes _apiRoutes = ApiRoutes();
  ButtonState buttonState = ButtonState.idle;
  List categories = <ProductCategory>[];
  List<ProductsInEachCat> products = [];
  List<UserCart> userCartItems = [];

  Future<void> getCategories() async {
    ResponseModel responseModel = await _apiService.call(
      method: HttpMethod.get,
      endpoint: '${_apiRoutes.baseUrl}${_apiRoutes.getCategory}',
    );
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

  Future<List<CartEntry>?> getUserCart({String? productId}) async {
    try {
      buttonState = ButtonState.loading;
      ResponseModel responseModel = await _apiService.call(
          method: HttpMethod.get,
          endpoint: 'https://fakestoreapi.com/carts/user/1');
      print('<<<<${responseModel.statusCode}>>>>');
      print(responseModel.response.body);
      if (responseModel.isSuccess) {
        buttonState = ButtonState.success;
        notifyListeners();
        var decodedData = jsonDecode(responseModel.response.body);
        List<CartEntry> responseData = (decodedData as List<dynamic>)
            .map((entry) => CartEntry.fromJson(entry))
            .toList();

        userCartItems =
            responseData.map((entry) => UserCart(userCarts: [entry])).toList();
        userCartItems.first.userCarts.first.products.first.productId;
        getSingleProductDetails(productId: productId);
        notifyListeners();
        return responseData;
      } else {
        buttonState = ButtonState.idle;
        notifyListeners();
        return null;
      }
    } catch (e, s) {
      throw Exception('Bad Request: $e, $s');
    }
  }

  Future<void> getSingleProductDetails({productId}) async {
    try {
      buttonState = ButtonState.loading;
      ResponseModel responseModel = await _apiService.call(
          method: HttpMethod.get,
          endpoint: 'https://fakestoreapi.com/products/$productId');
      print('<<<<${responseModel.statusCode}>>>>');
      print(responseModel.response.body);
      if (responseModel.isSuccess) {
        buttonState = ButtonState.success;
        notifyListeners();
        var decodedData = jsonDecode(responseModel.response.body);
        var responseData = SingleProductDetail.fromJson(decodedData);

        print('<<<<<${decodedData}');
        print('<<<<<${responseData.image}');
        notifyListeners();
      } else {
        buttonState = ButtonState.idle;
        notifyListeners();
      }
    } catch (e, s) {
      throw Exception('Bad Request: $e, $s');
    }
  }

  Future<List<ProductEntry>?> getUserCarts() async {
    try {
      buttonState = ButtonState.loading;
      ResponseModel responseModel = await _apiService.call(
        method: HttpMethod.get,
        endpoint: 'https://fakestoreapi.com/carts/user/1',
      );
      print('<<<<${responseModel.statusCode}>>>>');
      print(responseModel.response.body);
      if (responseModel.isSuccess) {
        buttonState = ButtonState.success;
        notifyListeners();
        var decodedData = jsonDecode(responseModel.response.body);
        List<ProductEntry> responseData =
            (decodedData as List<dynamic>).map((entry) {
          List<dynamic> products = entry['products'];
          return ProductEntry(
            productId: products[0]['productId'],
            quantity: products[0]['quantity'],
          );
        }).toList();
        print('>>>>${responseData[3].productId}>>>');


        // Assuming there can be multiple products in the cart for the user
        // If so, iterate through all products and add them to the responseData list

        notifyListeners();
        return responseData;
      } else {
        buttonState = ButtonState.idle;
        notifyListeners();
        return null;
      }
    } catch (e, s) {
      throw Exception('Bad Request: $e, $s');
    }
  }
}