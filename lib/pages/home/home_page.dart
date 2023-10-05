import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/pages/login/login_page.dart';
import 'package:sale_computer/pages/router/router_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => RouterPage.goTonext(
                      context: context,
                      navigateTo: const LoginPage(),
                    ),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Home page"),
      ),
    );
  }
}
