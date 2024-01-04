import 'package:e_commerce_app/components/c_text_form_field.dart';
import 'package:e_commerce_app/config/routes.dart';
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
            textControllor: controllers.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (str) => _validators.validateEmail(
              controllers.emailController.text,
            ),
            hintText: "Enter your email",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
          ),
          const SizedBox(height: 20),
          CTextFormField(
            textControllor: controllers.firstNameController,
            validator: (str) => _validators.validateEmptyTextField(
              controllers.firstNameController.text,
            ),
            hintText: "Enter your first name",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
          ),
          const SizedBox(height: 20),
          CTextFormField(
            hintText: "Enter your last name",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            textControllor: controllers.lastNameController,
            validator: (str) => _validators
                .validateEmptyTextField(controllers.lastNameController.text),
          ),
          const SizedBox(height: 20),
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
            keyboardType: TextInputType.phone,
            hintText: "Enter your phone number",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            textControllor: controllers.phoneNumberController,
            validator: (str) => _validators
                .validatesPhoneNumber(controllers.phoneNumberController.text),
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
                    controllers.phoneNumberController.text,
                    controllers.passwordController.text,
                    controllers.userNameController.text,
                    controllers.emailController.text,
                    controllers.firstNameController.text,
                    controllers.lastNameController.text,
                    controllers.cityController.text,
                    context,
                  );


                }

              },
              child: snapshot.buttonState == ButtonState.loading
                  ? customLoader()
                  : const Text("Create Account"),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
  void clear(){
    var controllers = Provider.of<AppControllers>(context, listen: false);
    controllers.phoneNumberController.dispose();
    controllers.passwordController.dispose();
    controllers.confirmPasswordController.dispose();
    controllers.firstNameController.dispose();
    controllers.userNameController.dispose();
    controllers.emailController.dispose();
    controllers.firstNameController.dispose();
    controllers.lastNameController.dispose();
    controllers.cityController.dispose();
  }
}