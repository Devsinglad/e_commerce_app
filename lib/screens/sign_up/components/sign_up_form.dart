import 'package:e_commerce_app/components/c_text_form_field.dart';
import 'package:e_commerce_app/config/routes.dart';
import 'package:e_commerce_app/utils/constants.dart';
import 'package:e_commerce_app/utils/enum.dart';
import 'package:e_commerce_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/c_indicator.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../data/auth/auth_repo.dart';
import '../../../provider/controller.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  Validators _validators = Validators();

  @override
  Widget build(BuildContext context) {
    var controllers = Provider.of<AppControllers>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CTextFormField(
            hintText: "Enter your username",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            textControllor: controllers.userNameController,
            validator: (str) => _validators
                .validateEmptyTextField(controllers.userNameController.text),
          ),
          const SizedBox(height: 20),
          CTextFormField(
            textControllor: controllers.cityController,
            validator: (str) => _validators
                .validateEmptyTextField(controllers.cityController.text),
            hintText: "Enter your City",
            suffixIcon: const CustomSurffixIcon(
                svgIcon: "assets/icons/Location point.svg"),
          ),
          const SizedBox(height: 20),
          CTextFormField(
            textControllor: controllers.passwordController,
            obscureText: false,
            validator: (str) => _validators
                .validatePassword(controllers.passwordController.text),
            hintText: "Enter your password",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
          const SizedBox(height: 20),
          CTextFormField(
            obscureText: false,
            textControllor: controllers.confirmPasswordController,
            validator: (str) => _validators.validateConfirmPassword(
                controllers.passwordController.text,
                controllers.confirmPasswordController.text),
            hintText: "Re-enter your password",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
          const SizedBox(height: 20),
          Consumer<AuthApi>(builder: (context, snapshot, _) {
            return ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  snapshot.signUp(
                    password: controllers.passwordController.text,
                    username: controllers.userNameController.text,
                    city: controllers.cityController.text,
                    context: context,
                  );
                }
              },
              child: snapshot.buttonState == ButtonState.loading
                  ? customLoader()
                  : const Text("Create Account"),
            );
          }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already Have an account?   "),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RouteGenerator.loginPage);
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



}