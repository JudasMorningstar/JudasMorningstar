import 'package:flutter/material.dart';
import 'package:holy_gram/screens/homeTab/homeTab.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/";
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeTab(),
        ],
      ),
    );
  }
}
