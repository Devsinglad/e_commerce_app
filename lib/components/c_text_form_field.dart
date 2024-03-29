// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class CTextFormField extends StatelessWidget {
  final TextEditingController? textControllor;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool? showCursor;
  void Function()? onTap;
  final String? Function(String?)? validator;
  void Function(String?)? onSaved;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  CTextFormField({
    super.key,
    this.textControllor,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.showCursor,
    this.onTap,
    this.validator,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onChanged,
    this.onFieldSubmitted,
    // this.minLines
  });

  final kInputFocusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: const BorderSide(color: kPrimaryLightColor, width: 1));

  final kInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: const BorderSide(color: Color(0xFFE2E4EA), width: 1));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textControllor,
      decoration: InputDecoration(
        hintStyle: hintTextStyle,

        filled: true,
        fillColor: fillColor,
        focusColor: kPrimaryColor,
        hintTextDirection: TextDirection.ltr,
        alignLabelWithHint: true,
        border: kInputBorder,
        enabledBorder: kInputBorder,
        focusedBorder: kInputFocusBorder,
        //contentPadding: REdgeInsets.all(10),

        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      style: inputTextStyle,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      showCursor: showCursor,
      onTap: onTap,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,

    );
  }
}