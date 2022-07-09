import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/services/firebase_services.dart';
import 'package:final_project/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/product_card.dart';
import '../constants.dart';
import '../screens/product_page.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        if (_searchString.isEmpty)
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: 150.0,
              ),
              child: Text("Search Results",
              style: Constants.regularDarkText,),
            ),
          )
        else
        FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef
                .orderBy("name")
                .startAt([_searchString]).endAt(["$_searchString\uf8ff"]).get(),
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
                    top: 128.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()!['images'][0],
                      price: "\$${document.data()!['price']}",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    productId: document.id,
                                  )),
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
        Padding(
          padding: const EdgeInsets.only(
            top: 45.0,
          ),
          child: CustomInput(
            hintText: "Search here...",
            onSubmitted: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
            },
          ),
        ),
      ],
    ));
  }
}
