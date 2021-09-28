import 'package:flutter/material.dart';
import 'package:holy_gram/widgets/image_swipe.dart';

class HomeTab extends StatelessWidget {
  List imageList = [
  "https://firebasestorage.googleapis.com/v0/b/holy-gram.appspot.com/o/IMG_3259.jpeg?alt=media&token=e9a7bc28-c4bc-4c8f-b35e-ba72e2293bd6",
  "https://firebasestorage.googleapis.com/v0/b/holy-gram.appspot.com/o/IMG_3791.JPG?alt=media&token=c12861e9-8830-4167-a722-a5c572f552e0",
  "https://firebasestorage.googleapis.com/v0/b/holy-gram.appspot.com/o/IMG_3263%20(1).jpeg?alt=media&token=2785e179-824e-4d2f-b3bd-f7194098fd83", 
  "https://firebasestorage.googleapis.com/v0/b/holy-gram.appspot.com/o/IMG_3295.jpeg?alt=media&token=e7fc2913-ab81-4630-a839-d8ef00e63c82", 
  ];
  
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ImageSwipe(
          imageList: imageList,
        ),
      ],
    );    
  }
} 