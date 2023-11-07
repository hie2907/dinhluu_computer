import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/pages/home/home_page.dart';
import 'package:sale_computer/pages/login/login_page.dart';
import 'package:sale_computer/pages/profile/components/profile_body.dart';
import 'package:sale_computer/pages/profile/profile_page.dart';
import 'package:sale_computer/pages/router/router_page.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.purple,
            ),
            accountName: Text(userModel.fullName),
            accountEmail: Text(userModel.emailAdress),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("images/none_profile.jpg"),
            ),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {
                RouterPage.goTonext(
                    context: context, navigateTo: const ProfileBody());
              },
              icon: const Icon(Icons.person),
            ),
            title: const Text("Profile"),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_rounded),
            ),
            title: const Text("Cart"),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            title: const Text("Favorite"),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_basket_sharp),
            ),
            title: const Text("My order"),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            title: const Text("Log out"),
          ),
        ],
      ),
    );
  }
}
