import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sale_computer/pages/login/login_page.dart';

class SignUpAuthProvider with ChangeNotifier {
  static Pattern pattern =
      "r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))";
  RegExp regExp = RegExp(SignUpAuthProvider.pattern.toString());
  UserCredential? userCredential;
  bool loading = false;
  void signupValidation({
    required TextEditingController? fullName,
    required TextEditingController? emailAdress,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (fullName!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fullname is empty"),
        ),
      );
      return;
    } else if (emailAdress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is empty"),
        ),
      );
      return;
      // } else if (!regExp.hasMatch(emailAdress.text.trim())) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text("Invalid email address"),
      //     ),
      //   );
      //   return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is empty"),
        ),
      );
      return;
    } else if (password.text.length <= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is shoot"),
        ),
      );
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAdress.text,
          password: password.text,
        );
        loading = true;
        notifyListeners();
        FirebaseFirestore.instance
            .collection("user")
            .doc(userCredential!.user!.uid)
            .set(
          {
            "fullName": fullName.text,
            "emailAddress": emailAdress.text,
            "password": password.text,
            "userUid": userCredential!.user!.uid,
          },
        ).then((value) {
          loading = false;
          notifyListeners();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "weak-password") {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("weak--password"),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("email-already-in-use"),
            ),
          );
        }
      }
    }
  }
}
