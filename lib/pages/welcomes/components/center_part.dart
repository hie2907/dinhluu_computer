import 'package:flutter/material.dart';

class CenterPart extends StatelessWidget {
  const CenterPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "images/logo.jpg",
      height: 300.0,
      width: 300.0,
    );
  }
}
