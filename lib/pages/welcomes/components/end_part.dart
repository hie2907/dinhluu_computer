import 'package:flutter/material.dart';
import 'package:sale_computer/appColors/appColors.dart';
import 'package:sale_computer/pages/login/login_page.dart';
import 'package:sale_computer/pages/router/router_page.dart';
import 'package:sale_computer/pages/signup/signup_page.dart';
import 'package:sale_computer/widget/my_button.dart';

class EndPart extends StatelessWidget {
  const EndPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: () {
            RouterPage.goTonext(
                context: context, navigateTo: const LoginPage());
          },
          text: "Login",
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            RouterPage.goTonext(
                context: context, navigateTo: const SignUpPage());
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: AppColors.KgreyColor,
            ),
          ),
        )
      ],
    );
  }
}
