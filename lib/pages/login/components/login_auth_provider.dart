import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/pages/home/home_page.dart';

class LoginAuthProvider with ChangeNotifier {
  bool loading = false;
  UserCredential? userCredential;
  void loginvalidation({
    required TextEditingController? email,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (email!.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("email is empty"),
        ),
      );
    } else if (password!.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is empty"),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is too short"),
        ),
      );
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then(
          (value) async {
            loading = false;
            notifyListeners();
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            return null;
          },
        );
        notifyListeners();
      } on FirebaseAuthException catch (e) {
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
