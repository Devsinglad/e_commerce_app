import 'package:flutter/material.dart';
class AppControllers extends ChangeNotifier{
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _confirmPasswordController=TextEditingController();
  final TextEditingController _firstNameController=TextEditingController();
  final TextEditingController _userNameController=TextEditingController();
  final TextEditingController _lastNameController=TextEditingController();
  final TextEditingController _phoneNumberController=TextEditingController();

  TextEditingController get firstNameController => _firstNameController;
  final TextEditingController _cityController=TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get userNameController => _userNameController;


  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  TextEditingController get fullNameController => _firstNameController;

  TextEditingController get lastNameController => _lastNameController;

  TextEditingController get phoneNumberController => _phoneNumberController;

  TextEditingController get cityController => _cityController;
}