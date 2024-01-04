import 'package:e_commerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CButton extends StatefulWidget {
  const CButton({
    required this.child,
    required this.onPressed,
    this.focusNode,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.key,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget child;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final void Function(bool)? onHover;
  final void Function()? onLongPress;

  @override
  final Key? key;

  @override
  State<CButton> createState() => _CButtonState();
}

class _CButtonState extends State<CButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(

        //disabledBackgroundColor: Color(0xFF292E32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        backgroundColor: kPrimaryColor,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      onHover: widget.onHover,
      onLongPress: widget.onLongPress,
      key: widget.key,
      child: widget.child,
    );
  }
}