import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:holy_gram/components/login_page.dart';
import '../constants.dart';
import './nav_bar.dart';

class LandingPage extends StatelessWidget {
  static String routeName = "/landing";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        //connection made to firebase
        if (snapshot.connectionState == ConnectionState.done) {
          //Stream Builder checks login state live
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                //if streamSnapshot has error
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${streamSnapshot.error}"),
                    ),
                  );
                }

                //connection state active = Do the user login chech inside the If statement.
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  //Get the User
                  User _user = streamSnapshot.data;

                  //if the user is null, then we're not logged in
                  if (_user == null) {
                    //user not logged in, redirect to Login.
                    return LoginPage();
                  } else {
                    //the user is logged in redirect to Homepage.
                    return NavBar();
                  }
                }

                // checking the Auth State -Loading
                return Scaffold(
                  body: Center(
                    child: Text(
                      "Checking Authentication...",
                      style: Constants.regularHeading,
                    ),
                  ),
                );
              });
        }

        //connectig to firebase -loading
        return Scaffold(
          body: Center(
            child: Text(
              "Initializing App...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
