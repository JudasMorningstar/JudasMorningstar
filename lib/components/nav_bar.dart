import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:holy_gram/screens/Profile/profile_screen.dart';
import 'package:holy_gram/screens/cart/cart_screen.dart';
import 'package:holy_gram/screens/favorites/favorites_screen.dart';
import 'package:holy_gram/screens/home/home_screen.dart';

class NavBar extends StatefulWidget {
  static String routeName = "/navbar";
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Widget _child;

  @override
  void initState() {
    _child = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
            svgPath: "assets/icons/Home.svg",
            // backgroundColor: Colors.black,
            extras: {"label": "home"},
          ),
          FluidNavBarIcon(
            svgPath: "assets/icons/Heart.svg",
            // backgroundColor: Color(0xFFFCBA02),
            extras: {"label": "WishList"},
          ),
          FluidNavBarIcon(
            svgPath: "assets/icons/Bag.svg",
            // backgroundColor: Color(0xFFFCBA02),
            extras: {"label": "Bag"},
          ),
          FluidNavBarIcon(
            svgPath: "assets/icons/Profile.svg",
            // backgroundColor: Color(0xFFFCBA02),
            extras: {"label": "profile"},
          ),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
          barBackgroundColor: Colors.black,
          iconSelectedForegroundColor: Color(0xFFFCBA02),
          iconUnselectedForegroundColor: Color(0xFFFCBA02),
          // iconBackgroundColor: Colors.white,
        ),
        scaleFactor: 1.5,
        defaultIndex: 0,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomeScreen();
          break;
        case 1:
          _child = Favorites();
          break;
        case 2:
          _child = CartScreen();
          break;
        case 3:
          _child = ProfileScreen();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
