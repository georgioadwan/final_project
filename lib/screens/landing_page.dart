import 'package:final_project/constants.dart';
import 'package:final_project/screens/home_page.dart';
import 'package:final_project/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // if snapshot has error
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          // Connection Initialized - Firebase App is running
          if (snapshot.connectionState == ConnectionState.done) {
            //StreamBuilder can check the login state live
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${streamSnapshot.error}"),
                      ),
                    );
                  }

                  // Connection state active - Do the user login inside the if statement
                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    // Get the user
                    User? user = streamSnapshot.data as User?;

                    //if the user is null, we're not logged in
                    if (user == null) {
                      // head to login page
                      return LoginPage();
                    } else {
                      // The user is logged in head to homepage
                      return HomePage();
                    }
                  } else {
                    // checking the auth state - loading
                    return Scaffold(
                        body: Center(
                      child: Text(
                        "Checking Authentication...",
                        style: Constants.regularHeading,
                      ),
                    ));
                  }
                });
          }
          return Scaffold(
              body: Center(
            child: Text(
              "App Initializing..",
              style: Constants.regularHeading,
            ),
          ));
        });
  }
}
