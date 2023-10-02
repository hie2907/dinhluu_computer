import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_computer/pages/login/login_page.dart';
import 'package:sale_computer/pages/signup/components/signup_auth_provider.dart';
import 'package:sale_computer/widget/my_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAdress = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    SignUpAuthProvider signUpAuthProvider =
        Provider.of<SignUpAuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: fullName,
                    decoration: const InputDecoration(
                      hintText: "Full Name",
                    ),
                  ),
                  TextFormField(
                    controller: emailAdress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: visibility,
                    decoration: InputDecoration(
                        hintText: "Password ",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          },
                          icon: Icon(
                            visibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  signUpAuthProvider.loading == false
                      ? MyButton(
                          onPressed: () {
                            signUpAuthProvider.signupValidation(
                                fullName: fullName,
                                context: context,
                                emailAdress: emailAdress,
                                password: password);
                          },
                          text: "Sign Up",
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  Row(
                    children: [
                      const Text("Already have account?\t\t"),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
