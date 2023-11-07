import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/pages/home/home_page.dart';
import 'package:sale_computer/pages/router/router_page.dart';
import 'package:sale_computer/widget/my_button.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool isEdit = false;
  TextEditingController fullName =
      TextEditingController(text: userModel.fullName);
  TextEditingController emailAdress =
      TextEditingController(text: userModel.emailAdress);

  Widget textFormInput(String hintText) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          fillColor: const Color.fromARGB(255, 129, 105, 105),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  void profilevalidation({
    required TextEditingController? fullName,
    required TextEditingController? emailAdress,
    required BuildContext context,
  }) async {
    if (fullName!.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fullname is empty"),
        ),
      );
    } else if (emailAdress!.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is empty"),
        ),
      );
    } else if (emailAdress.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is too short"),
        ),
      );
    } else {
      buildUpdateprofile();
    }
  }

  Widget nonFormInput() {
    return Column(
      children: [
        const SizedBox(
          height: 115,
          width: 115,
          child: CircleAvatar(
            backgroundImage: AssetImage("images/none_profile.jpg"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        textFormInput(
          userModel.emailAdress,
        ),
        const SizedBox(
          height: 10,
        ),
        textFormInput(
          userModel.fullName,
        ),
      ],
    );
  }

  Widget editTextField() {
    return Column(
      children: [
        const SizedBox(
          height: 115,
          width: 115,
          child: CircleAvatar(
            backgroundImage: AssetImage("images/none_profile.jpg"),
          ),
        ),
        TextFormField(
          controller: fullName,
          decoration: InputDecoration(
            hintText: userModel.fullName,
          ),
        ),
        TextFormField(
          controller: emailAdress,
          decoration: InputDecoration(
            hintText: userModel.emailAdress,
          ),
        ),
        MyButton(
          onPressed: () {
            profilevalidation(
              emailAdress: emailAdress,
              fullName: fullName,
              context: context,
            );
          },
          text: "Update",
        )
      ],
    );
  }

  Future buildUpdateprofile() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "fullName": fullName.text,
      "emailAddress": emailAdress.text,
    }).then(
      (value) => RouterPage.goTonext(
        context: context,
        navigateTo: const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        centerTitle: true,
        leading: isEdit
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: const Icon(Icons.close),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEdit = true;
              });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isEdit ? editTextField() : nonFormInput(),
          ),
        ],
      ),
    );
  }
}
