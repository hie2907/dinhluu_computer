import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/pages/login/login_page.dart';
import 'package:sale_computer/pages/router/router_page.dart';
import 'package:sale_computer/widget/build_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
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
      ),
      body: Center(
        child: Text("Home page"),
      ),
    );
  }
}
