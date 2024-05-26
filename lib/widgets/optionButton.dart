import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/cupertino.dart';

class OptionButton extends HookWidget {
  final String title;
  final Function() onTap;
  final Icon icon;

  OptionButton({
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                // circle blue background
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(238, 238, 238, 1),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                    padding: EdgeInsets.all(6.0),
                    // setting the icon of the class
                    child: icon),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(CupertinoIcons.right_chevron),
        ],
      ),
    );
  }
}
