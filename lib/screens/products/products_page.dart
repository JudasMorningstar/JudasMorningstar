import 'package:flutter/material.dart';
import 'package:holy_gram/widgets/image_swipe.dart';
import '/constants.dart';
import 'package:holy_gram/services/firebaseServices.dart';

import 'components/products_card.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  //User -> UserID (Document) -> Cart ->

  // User _user = FirebaseAuth.instance.currentUser;
  String _selectedProductSize = "0";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToWishList() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Wish List")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _customSnackBar = new SnackBar(
    content: Text("Product added to Wish List."),
  );

  final SnackBar _snackBar = new SnackBar(
    content: Text("Product added to Cart"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              //if snapshot has error
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //firebase Document Data map
                Map<String, dynamic> documentData = snapshot.data.data();

                //list of images
                List imageList = documentData['image'];
                //list of sizes
                // List productSizes = documentData['size'];

                //set initial size
                // _selectedProductSize = productSizes[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "${documentData['name']}" ?? "Product Name",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "R${documentData['price']}" ?? "Price",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['description']}" ?? "Desription",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 24.0,
                    //     horizontal: 24.0,
                    //   ),
                    //   child: Text(
                    //     "Select Size",
                    //     style: Constants.regularDarkText,
                    //   ),
                    // ),
                    // ProductSize(
                    //   productSizes: productSizes,
                    //   onSelected: (size) {
                    //     _selectedProductSize = size;
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _addToWishList();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_customSnackBar);
                            },
                            child: Container(
                              width: 65.0,
                              height: 65.0,
                              decoration: BoxDecoration(
                                color: Color(0xffdcdcdc),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                  "assets/images/Heart.png",
                                ),
                                height: 30.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToCart();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_snackBar);
                                // Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 65.0,
                                margin: EdgeInsets.only(
                                  left: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }

              // Loading state
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            },
          ),
          // CustomActionBar(
          //   hasBackArrow: true,
          //   hasTitle: false,
          //   hasBackground: false,
          // ),
        ],
      ),
    );
  }
}
