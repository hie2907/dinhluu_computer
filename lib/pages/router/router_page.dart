import 'package:flutter/material.dart';

class RouterPage {
  static goTonext({required BuildContext context, required Widget navigateTo}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => navigateTo),
    );
  }
}