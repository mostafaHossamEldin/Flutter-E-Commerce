import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bell),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
