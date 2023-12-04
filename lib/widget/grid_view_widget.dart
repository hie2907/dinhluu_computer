import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sale_computer/appColors/appColors.dart';
import 'package:sale_computer/widget/products.dart';

class GridViewWidget extends StatelessWidget {
  final String id;
  final String collection;
  const GridViewWidget({
    super.key,
    required this.id,
    required this.collection,
  });

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("categories")
            .doc(id)
            .collection(collection)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
          // if (!snapshort.hasData) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          return Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Material(
              //     elevation: 7,
              //     shadowColor: Colors.grey[300],
              //     child: TextFormField(
              //       decoration: const InputDecoration(
              //           prefixIcon: Icon(Icons.search),
              //           fillColor: AppColors.KwiteColor,
              //           hintText: "Search prorduct",
              //           filled: true,
              //           border: OutlineInputBorder(
              //             borderSide: BorderSide.none,
              //           )),
              //     ),
              //   ),
              // ),
              GridView.builder(
                // shrinkWrap: true,
                // itemCount: snapshort.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.red,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
