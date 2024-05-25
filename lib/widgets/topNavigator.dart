import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './drawer.dart';

class CustomTopNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(45, 50, 45, 30),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 45,
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.list_bullet,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  IconButton(
                    iconSize: 45,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomDrawer(),
                        ),
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.profile_circled,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
