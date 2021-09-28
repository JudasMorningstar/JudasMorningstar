import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const regularHeading = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.5,
  );

  static const whiterHeading = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.5,
  );

  static const boldHeading = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const regularDarkText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const badgeText = TextStyle(
    color: primary,
  );

  static const primaryGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFCBA02),
      Color(0xFFFFA53E),
    ],
  );

  static const animationDuration = Duration(milliseconds: 200);
  static const white = Colors.white;
  static const secondary = Color(0xff323335);
  static const lightGray = Color(0xffc0c1c3);
  static const lighterGray = Color(0xffe0e0e0);
  static const black = Colors.black;
  static const primary = Color(0xFFFCBA02);
  static const tertiary = Color(0xffff36b6b);
  static const cbd = Color(0xff558b2f);
}
