import 'package:e_commerce_app/components/c_indicator.dart';
import 'package:e_commerce_app/data/auth/auth_repo.dart';
import 'package:e_commerce_app/utils/enum.dart';
import 'package:e_commerce_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../components/c_text_form_field.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../provider/controller.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();

  final Validators _validators = Validators();

  @override
  Widget build(BuildContext context) {
    var controllers = Provider.of<AppControllers>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CTextFormField(
            keyboardType: TextInputType.text,
            textControllor: controllers.userNameController,
            hintText: "Enter your username",
            validator: (str) => _validators
                .validateEmptyTextField(controllers.userNameController.text),
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
          ),
          const SizedBox(height: 20),
          CTextFormField(
            textControllor: controllers.passwordController,
            obscureText: false,
            validator: (str) => _validators
                .validateEmptyTextField(controllers.passwordController.text),
            hintText: "Enter your password",
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
          SizedBox(height: 20.h),
          Consumer<AuthApi>(builder: (context, snapshot, _) {
            return ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  snapshot.signIn(controllers.userNameController.text,
                      controllers.passwordController.text, context);
                  print(controllers.userNameController.text);
                }
              },
              child: snapshot.buttonState == ButtonState.loading
                  ? customLoader()
                  : const Text("Sign In"),
            );
          }),
        ],
      ),
    );
  }
}