import 'package:flutter/material.dart';
import 'package:sale_computer/pages/welcomes/components/center_part.dart';
import 'package:sale_computer/pages/welcomes/components/end_part.dart';
import 'package:sale_computer/pages/welcomes/components/top_part.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //top part
            TopPart(),

            //center part
            CenterPart(),

            //End part
            EndPart(),
          ],
        ),
      ),
    );
  }
}
