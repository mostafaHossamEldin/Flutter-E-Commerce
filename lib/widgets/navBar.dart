import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/routesProvider.dart';
import '../providers/authProvider.dart';

class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<MyGoRouter>(context);
    final isLoggedIn = Provider.of<AAProvider>(context).isLoggedIn;
    final currentRoute = routeProvider.currentRoute;
    final selectedIndex = (currentRoute == '/'
        ? 0
        : currentRoute == '/cart'
            ? 1
            : currentRoute == '/notifications'
                ? 2
                : currentRoute == '/profile'
                    ? 3
                    : currentRoute == '/login'
                        ? 1
                        : 2);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: isLoggedIn
            ? [
                Container(
                  // Home
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? const Color.fromRGBO(38, 53, 110, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: IconButton(
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                    iconSize: 35,
                    icon: const Icon(CupertinoIcons.house_fill),
                    onPressed: () {
                      routeProvider.getRouter.pushNamed('home');
                    },
                  ),
                ),
                Container(
                  // Cart
                  decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? const Color.fromRGBO(38, 53, 110, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                        iconSize: 35,
                        icon: const Icon(CupertinoIcons.cart_fill),
                        onPressed: () {
                          routeProvider.getRouter.pushNamed('cart');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  // Notification
                  decoration: BoxDecoration(
                    color: selectedIndex == 2
                        ? const Color.fromRGBO(38, 53, 110, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        color: selectedIndex == 2 ? Colors.white : Colors.black,
                        iconSize: 35,
                        icon: const Icon(CupertinoIcons.bell_fill),
                        onPressed: () {
                          routeProvider.getRouter.pushNamed('notifications');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  // Profile
                  decoration: BoxDecoration(
                    color: selectedIndex == 3
                        ? const Color.fromRGBO(38, 53, 110, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        color: selectedIndex == 3 ? Colors.white : Colors.black,
                        iconSize: 35,
                        icon: const Icon(CupertinoIcons.person_fill),
                        onPressed: () {
                          routeProvider.getRouter.pushNamed('profile');
                        },
                      ),
                    ],
                  ),
                ),
              ]
            : [
                Container(
                  // Home
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? const Color.fromRGBO(38, 53, 110, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: IconButton(
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                    iconSize: 35,
                    icon: const Icon(CupertinoIcons.house_fill),
                    onPressed: () {
                      routeProvider.getRouter.pushNamed('home');
                    },
                  ),
                ),
                Container(
                  // Login
                  decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? const Color.fromRGBO(38, 53, 110, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                        iconSize: 35,
                        icon: const Icon(CupertinoIcons.person_fill),
                        onPressed: () {
                          print('\n\n\n\n\n\nlogin\n\n\n\n\n\n');
                          routeProvider.getRouter.pushNamed('login');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  // Signup
                  decoration: BoxDecoration(
                    color: selectedIndex == 2
                        ? const Color.fromRGBO(38, 53, 110, 1)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        color: selectedIndex == 2 ? Colors.white : Colors.black,
                        iconSize: 35,
                        icon: const Icon(CupertinoIcons.person_badge_plus_fill),
                        onPressed: () {
                          routeProvider.getRouter.pushNamed('signup');
                        },
                      ),
                    ],
                  ),
                ),
              ],
      ),
    );
  }
}
