import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {

  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                   SizedBox(height: 16.h),
                  const Text("Register Account", style: headingStyle),
                  const Text(
                    "Complete your details",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const SignUpForm(),
                  const SizedBox(height: 16),
                  Text(
                    'By continuing your confirm that you agree \nwith our Term and Condition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}