import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Paintings");

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
                    return Container (
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: 350.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      //child: Text("Name: ${document.data()!['name']}"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          "${document.data()!['images'][0]}",
                          fit: BoxFit.cover,
                        ),
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
          title: "Home",
          hasBackArrow: true,
        ),
      ],
    ));
  }
}
