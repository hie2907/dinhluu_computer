import 'package:flutter/material.dart';
import 'package:sale_computer/widget/my_button.dart';

class EndPart extends StatelessWidget {
  const EndPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: () {},
          text: "Login",
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            print("click");
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color(0xff797b7a),
            ),
          ),
        )
      ],
    );
  }
}
