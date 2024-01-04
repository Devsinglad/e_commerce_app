import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/no_account_text.dart';
import '../../provider/controller.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<AppControllers>(context,listen: false);
    provider.userNameController.text = 'johnd';
    provider.passwordController.text = r'm38rmF$';
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in with your email and password",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  SignForm(),
                  SizedBox(height: 16),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}