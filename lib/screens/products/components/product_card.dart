import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String name;
  final String title;
  final String price;

  ProductCard({
    this.onPressed,
    this.imageUrl,
    this.name,
    this.title,
    this.productId,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[300],
        ),
        height: 250,
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              width: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$imageUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromRGBO(255, 245, 214, 0.8),
                  ),
                  // height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
