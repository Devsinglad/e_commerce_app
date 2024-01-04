import 'dart:convert';
import 'package:e_commerce_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../../config/routes.dart';
import '../../core/api_const.dart';
import '../../core/base_api.dart';
import '../../core/base_response.dart';
import '../../provider/controller.dart';
import '../../utils/enum.dart';
import '../database.dart';
import 'package:http/http.dart'as http;

class AuthApi extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final ApiRoutes _apiRoutes = ApiRoutes();
  ButtonState buttonState = ButtonState.idle;
  HiveStorage hiveStorage = HiveStorage(Hive.box(HiveKeys.appBox));
  String userNumber = '';

  Future<void> signUp(phoneNumber, password, username, email, firstName,
      lastName, city, context) async {
    buttonState = ButtonState.loading;
    notifyListeners();
    ResponseModel responseModel = await _apiService.call(
      method: HttpMethod.post,
      endpoint: '${_apiRoutes.baseUrl}${_apiRoutes.signUpAuth}',
      reqBody: {
        'email': email,
        'username': username,
        'password': password,
        'name': {
          'firstname': firstName,
          'lastname': lastName,
        },
        'address': {
          'city': city,
          'street': '7835 new road',
          'number': '3',
          'zipcode': '12926-3874',
          'geolocation': {
            'lat': '-37.3159',
            'long': '81.1496',
          },
        },
        'phone': phoneNumber,
      },
    );
    if (responseModel.isSuccess) {
      var controllers = Provider.of<AppControllers>(context, listen: false);
      buttonState = ButtonState.success;
      notifyListeners();
      toastMessage(text: 'Account Created');
      controllers.phoneNumberController.clear();
      controllers.passwordController.clear();
      controllers.confirmPasswordController.clear();
      controllers.firstNameController.clear();
      controllers.emailController.clear();
      controllers.userNameController.clear();
      controllers.firstNameController.clear();
      controllers.lastNameController.clear();
      controllers.cityController.clear();

      Navigator.pushNamed(context, RouteGenerator.loginPage);
    } else {
      buttonState = ButtonState.idle;
      toastMessage(text: responseModel.response.body, isError: true);
      notifyListeners();
    }
  }
  void signIn(username, password, context) async {
    final url = Uri.parse('https://fakestoreapi.com/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'username': 'mor_2314',
          'password': '83r5^_',
        },
      ),
    );

    if (response.statusCode == 200) {
      buttonState = ButtonState.success;
      notifyListeners();
      var decode = jsonDecode(response.body);
       await hiveStorage.put(HiveKeys.token, decode['token']);
      Navigator.pushReplacementNamed(
          context, RouteGenerator.loginSuccessScreen);
      print('Response: $decode');
      getStoredToken();
    } else {
      buttonState = ButtonState.idle;
      toastMessage(text: response.body, isError: true);

      notifyListeners();
      print('Request failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }


  String? getStoredToken() {
    var token = hiveStorage.get<String?>(HiveKeys.token);
    print('save_token: $token');
    notifyListeners();
    return token;
  }




}