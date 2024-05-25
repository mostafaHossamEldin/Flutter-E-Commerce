import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
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
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(38, 53, 110, 1),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // onNavigate('/');
            },
          ),
          ListTile(
            title: const Text('Cart'),
            onTap: () {
              // onNavigate('/cart');
            },
          ),
          ListTile(
            title: const Text('Notifications'),
            onTap: () {
              // onNavigate('/notifications');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // onNavigate('/profile');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // onLogout();
            },
          ),
        ],
      ),
    );
  }
}
