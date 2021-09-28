import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/products/components/product_card.dart';
import '../screens/products/products_page.dart';
import '../services/firebaseServices.dart';
import './custom_input.dart';
import '../constants.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
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
                  top: 45.0,
                ),
                child: Text(
                  "Search Results",
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productRef.orderBy("name") //
                  .startAt([_searchString]) //
                  .endAt(["$_searchString\uf8ff"]) //
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
                    padding: EdgeInsets.only(
                      top: 112.0,
                      bottom: 70.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductCard(
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: "R${document.data()['price']}",
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

                //loading state
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              },
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInput(
              hintText: "Search here...",
              onSubmitted: (value) {
                setState(() {
                  _searchString = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
