import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const Color fillColor = Color(0xFFFFFFFF);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final hintTextStyle = TextStyle(
  fontFamily: 'Muli',
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
  color: const Color(0xFF9FA4AB),
);

final inputTextStyle = TextStyle(
  fontFamily: 'Muli',
  fontSize: 15.sp,
  fontWeight: FontWeight.w500,
  color: const Color(0xFF160D07),
);
const defaultDuration = Duration(milliseconds: 250);