import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holy_gram/screens/products/products_page.dart';
import 'package:holy_gram/services/firebaseServices.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserId())
                .collection("Cart")
                .get(),
            builder: (context, snapshot) {
              //if snapshot has error
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //collection data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // display the data in a list
                return ListView(
                  // padding: EdgeInsets.only(
                  //   top: 12.0,
                  //   left: 12.0,
                  //   right: 12.0,
                  //   bottom: 70.0,
                  // ),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              productId: document.id,
                            ),
                          ),
                        );
                      },
                      child: FutureBuilder(
                        future:
                            _firebaseServices.productRef.doc(document.id).get(),
                        builder: (context, productSnap) {
                          if (productSnap.hasError) {
                            return Container(
                              child: Center(
                                child: Text("${productSnap.error}"),
                              ),
                            );
                          }

                          if (productSnap.connectionState ==
                              ConnectionState.done) {
                            Map productMap = productSnap.data.data();

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: (16),
                                horizontal: (24),
                              ),
                              margin: const EdgeInsets.only(
                                bottom: 8.0,
                                left: 8.0,
                                right: 8.0,
                                top: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "${productMap['image'][0]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${productMap['name']}",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                          ),
                                          child: Text(
                                            "R${productMap['price']}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   "Size - ${document.data()['size']}",
                                        //   style: TextStyle(
                                        //     fontSize: 16.0,
                                        //     color: Colors.white,
                                        //     fontWeight: FontWeight.w600,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
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
            },
          ),
          // CustomAppBar(
          //   hasBackArrow: true,
          //   hasTitle: true,
          //   hasBackground: true,
          //   title: "Cart",
          // )
        ],
      ),
    );
  }
}
