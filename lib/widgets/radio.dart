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

class CustomRadioBig extends HookWidget {
  final String text;
  final String defaultValue;
  final Function(String) controller;
  final String option1;
  final String option2;

  CustomRadioBig({
    required this.text,
    required this.defaultValue,
    required this.controller,
    required this.option1,
    required this.option2,
  });

  @override
  Widget build(BuildContext context) {
    final tag = useState(defaultValue);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1C),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              tag.value = option1;
              controller(option1);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                color: tag.value == option1
                    ? Color.fromARGB(255, 38, 53, 110)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: tag.value == option1
                      ? Color.fromARGB(255, 38, 53, 110)
                      : Color.fromARGB(162, 162, 162, 162),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: tag.value == option1
                            ? Color.fromARGB(255, 38, 53, 110)
                            : Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: tag.value == option1
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(162, 162, 162, 162),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    option1,
                    style: TextStyle(
                        color: tag.value == option1
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(162, 162, 162, 162),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              tag.value = option2;
              controller(tag.value);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                color: tag.value == option2
                    ? Color.fromARGB(255, 38, 53, 110)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: tag.value == option2
                      ? Color.fromARGB(255, 38, 53, 110)
                      : Color.fromARGB(162, 162, 162, 162),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: tag.value == option2
                            ? Color.fromARGB(255, 38, 53, 110)
                            : Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: tag.value == option2
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(162, 162, 162, 162),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    option2,
                    style: TextStyle(
                        color: tag.value == option2
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(162, 162, 162, 162),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
