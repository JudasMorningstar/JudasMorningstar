import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  //
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //
  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference productRef =
      FirebaseFirestore.instance.collection("products");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");
  
  final CollectionReference bannerRef =
      FirebaseFirestore.instance.collection("banner");

  // String getCartId() {
  //   return _firebaseAuth.currentUser.uid;
  // }
}
