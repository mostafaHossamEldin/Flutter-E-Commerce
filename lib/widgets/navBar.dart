import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomNavBar extends HookWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  CustomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
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
        // how to drop shadow in flutter
        // https://stackoverflow.com/questions/51100268/how-to-add-shadow-to-a-container-in-flutter
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
                onItemTapped(0);
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
                    onItemTapped(1);
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
                    onItemTapped(2);
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
                    onItemTapped(3);
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
