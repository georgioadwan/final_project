import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/product_page.dart';
import 'package:final_project/widgets/custom_action_bar.dart';
import 'package:final_project/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference<Map<String, dynamic>> _productsRef = FirebaseFirestore.instance.collection("Paintings");

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 100.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return ProductCard(
                      title: document['name'],
                      imageUrl: document['images'][0],
                      price: "\$${document['price']}",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              productId: document.id,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
        CustomActionBar(
          title: "Home",
          hasBackArrow: false,
        ),
      ],
    ));
  }
}
