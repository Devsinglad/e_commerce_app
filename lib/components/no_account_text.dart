import 'package:e_commerce_app/config/routes.dart';
import 'package:flutter/material.dart';

import '../screens/sign_up/sign_up_screen.dart';
import '../utils/constants.dart';


class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, RouteGenerator.registerPage),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 16, color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}