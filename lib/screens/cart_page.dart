import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/product_page.dart';
import 'package:final_project/services/firebase_services.dart';
import 'package:final_project/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserID())
                  .collection("Cart")
                  .get(),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        productId: document.id,
                                      )));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productsRef.doc(document.id).get(),
                          builder: (context, paintingSnap) {
                            if (paintingSnap.hasError) {
    return Container(
    child: Center(
    child: Text("${paintingSnap.error}"),
    ),
    );
    }
                              if (paintingSnap.connectionState ==
                                  ConnectionState.done) {
                                Map _paintingMap = paintingSnap.data!.data();

                                return Padding (
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                          height: 90,
                                        child: ClipRRect (
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network("${_paintingMap['images'][0]}",
                                          fit: BoxFit.cover,
                                          )
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${_paintingMap['name']}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600
                                            ),),
                                            Padding(padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text("\$${_paintingMap['price']}",
                                                style: TextStyle (
                                                fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                            ),
                                            Text("Size - ${document.data()!['size']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                              color: Colors.black,
                                            ),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Container(
                                    child: Text("${_paintingMap['name']}"),
                                  ),
                                );
                              }
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                          },
                        ),
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
            hasBackArrow: true,
            title: "Cart",
          )
        ],
      ),
    );
  }
}
