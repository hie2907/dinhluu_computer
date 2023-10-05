import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/pages/login/login_page.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            accountName: Text("Hie297"),
            accountEmail: Text("trandinhhieu20152@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/logo.jpg"),
            ),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
            title: const Text("Profile"),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_rounded),
            ),
            title: Text("Cart"),
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
