import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomRadio extends HookWidget {
  final String text;
  final bool defaultValue;
  final Function(bool) controller;

  CustomRadio({
    required this.text,
    required this.defaultValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var isSelected = useState(defaultValue);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C1C1C),
          ),
        ),
        CupertinoSwitch(
          value: isSelected.value,
          onChanged: (value) {
            isSelected.value = value;
            controller(value);
          },
          activeColor: const Color.fromRGBO(38, 53, 110, 1),
        ),
      ],
    );
  }
}
