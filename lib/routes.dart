import 'package:flutter/material.dart';
import 'package:holy_gram/components/landing_page.dart';
import 'package:holy_gram/components/nav_bar.dart';
import 'package:holy_gram/screens/Profile/profile_screen.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LandingPage.routeName: (context) => LandingPage(),
  NavBar.routeName: (context) => NavBar(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CartScreen.routeName: (context) => CartScreen(),
};
