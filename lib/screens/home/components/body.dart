import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:holy_gram/screens/products/components/product_card.dart';
import 'package:holy_gram/screens/products/products_page.dart';

class Body extends StatelessWidget {
  // const Body({Key key}) : super(key: key);
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _productRef.get(),
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
                  return StaggeredGridView.count(                    
                    crossAxisCount: 4,
                    staggeredTiles: const <StaggeredTile>[
                      StaggeredTile.count(4, 2),
                      StaggeredTile.count(2, 1),
                      StaggeredTile.count(2, 2),
                      StaggeredTile.count(2, 1),
                    ],
                    children: snapshot.data.docs.map((document) {
                      return 
                      ProductCard(
                        title: document.data()['name'],
                        imageUrl: document.data()['image'][0],
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
                    // staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  );
                }

                //loading state
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
