import 'package:flutter/material.dart';
import 'package:holy_gram/components/landing_page.dart';
import 'package:holy_gram/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFFFCBA02),
      ),
      initialRoute: LandingPage.routeName,
      routes: routes,
    );
  }
}
