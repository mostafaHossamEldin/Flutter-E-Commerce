import 'package:flutter/material.dart';

class CustomDrawer extends AppBar {
  // final Function(String) onNavigate;
  // final Function() onLogout;

  // CustomDrawer({
  //   required this.onNavigate,
  //   required this.onLogout,
  // });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(38, 53, 110, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Travel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Gear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Cart'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
