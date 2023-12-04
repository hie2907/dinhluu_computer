import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/appColors/appColors.dart';
import 'package:sale_computer/model/user_model.dart';
import 'package:sale_computer/pages/router/router_page.dart';
import 'package:sale_computer/widget/build_drawer.dart';
import 'package:sale_computer/widget/grid_view_widget.dart';
import 'package:sale_computer/widget/products.dart';

late UserModel userModel;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userModel = UserModel.fromDocument(documentSnapshot);
        } else {
          print("Document does not exits the database");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserDataFunction();
    return Scaffold(
      drawer: const BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 7,
              shadowColor: Colors.grey[300],
              child: TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    fillColor: AppColors.KwiteColor,
                    hintText: "Search prorduct",
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          ),
          const ListTile(
            leading: Text(
              "Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            height: 100,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                if (!streamSnapshort.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: streamSnapshort.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    return Categories(
                      onTap: () {
                        RouterPage.goTonext(
                          context: context,
                          navigateTo: GridViewWidget(
                            collection: streamSnapshort.data!.docs[index]
                                ["categoryName"],
                            id: streamSnapshort.data!.docs[index].id,
                          ),
                        );
                      },
                      image: streamSnapshort.data!.docs[index]["categoryImage"],
                      categoryName: streamSnapshort.data!.docs[index]
                          ["categoryName"],
                    );
                  },
                );
              },
            ),
          ),
          const ListTile(
            leading: Text(
              "Product",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Products(),
                Products(),
              ],
            ),
          ),
          const ListTile(
            leading: Text(
              "Best Sell",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Products(),
                Products(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final Function()? onTap;
  const Categories({
    super.key,
    required this.onTap,
    required this.image,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 100,
        width: 170,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(categoryName),
        ),
      ),
    );
  }
}
