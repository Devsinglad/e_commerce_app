import 'dart:async';
import 'package:e_commerce_app/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../provider/controller.dart';
import '../../utils/enum.dart';
import '../localDB/database.dart';

class AuthApi extends ChangeNotifier {
  ButtonState buttonState = ButtonState.idle;
  Future<void> signUp({
    required String password,
    required String username,
    required String city,
    required context,
  }) async {
    buttonState = ButtonState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    await Hive.openBox<User>(HiveKeys.user);
    final userBox = Hive.box<User>(HiveKeys.user);

    if (userBox.values.any((element) => element.username == username)) {
      buttonState = ButtonState.idle;
      toastMessage(text: 'Username already exists', isError: true);
      notifyListeners();
      return;
    }

    final newUser = User(
      username: username,
      city: city,
      password: password,
    );

    userBox.add(newUser);

    var controllers = Provider.of<AppControllers>(context, listen: false);
    buttonState = ButtonState.success;
    notifyListeners();

    toastMessage(text: 'Account Created');
    controllers.passwordController.clear();
    controllers.confirmPasswordController.clear();
    controllers.userNameController.clear();
    controllers.cityController.clear();
    Navigator.pop(context);
  }

  void signIn(String username, String password, context) async {
    var controllers = Provider.of<AppControllers>(context, listen: false);

    try {
      buttonState = ButtonState.loading;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      final userBox = Hive.box<User>(HiveKeys.user);

      for (var i = 0; i < userBox.length; i++) {
        final user = userBox.getAt(i);
        print("Username: ${user?.username}, Password: ${user?.password}");

        if (user != null &&
            user.username == username &&
            user.password == password) {
          buttonState = ButtonState.success;
          notifyListeners();
          toastMessage(text: "Sign in successful", isError: false);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const LoginSuccessScreen()));
          controllers.passwordController.clear();
          controllers.userNameController.clear();
          return;
        }
      }

      buttonState = ButtonState.idle;
      toastMessage(text: 'Invalid Details', isError: true);
      controllers.passwordController.clear();
      controllers.userNameController.clear();
      notifyListeners();
    } catch (e) {
      toastMessage(text: 'Sign in Error');
      buttonState = ButtonState.idle;
      notifyListeners();
    }
  }
}