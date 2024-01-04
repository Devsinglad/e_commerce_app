
import 'package:flutter/material.dart';

import '../screens/cart/cart_screen.dart';
import '../screens/details/details_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/init_screen.dart';
import '../screens/login_success/login_success_screen.dart';
import '../screens/products/products_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../screens/sign_up/sign_up_screen.dart';
import '../screens/splash/splash_screen.dart';

class RouteGenerator {
  static const String splashPage = 'splashPage';
  static const String initScreen = 'initScreen';
  static const String loginPage = 'loginPage';
  static const String registerPage = 'registerPage';
  static const String profilePage = 'profilePage';
  static const String homeScreen = 'HomeScreen';
  static const String loginSuccessScreen = 'LoginSuccessScreen';
  static const String cartScreen = 'CartScreen';
  static const String detailsScreen = 'DetailsScreen';
  static const String productsScreen = 'ProductsScreen';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case initScreen:
        return MaterialPageRoute(builder: (_) => const InitScreen());
      case splashPage:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case registerPage:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case homeScreen:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen());
      case loginSuccessScreen:
        return MaterialPageRoute(builder: (_) => const LoginSuccessScreen());
        case cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
        case detailsScreen:
        return MaterialPageRoute(builder: (_) => const DetailsScreen());
        case productsScreen:
        return MaterialPageRoute(builder: (_) => const ProductsScreen());


      default:
        throw Exception('Route not found');
    }
  }
}