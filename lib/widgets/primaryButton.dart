import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomPrimaryButton extends HookWidget {
  final String text;
  final void Function() onPressed;
  final double width;
  final double height;

  CustomPrimaryButton({
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(38, 53, 110, 1),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(width, height),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ));
  }
}

class CustomPrimaryButton2 extends HookWidget {
  final String text;
  final void Function() onPressed;
  final double width;
  final double height;
  final Icon icon;

  CustomPrimaryButton2({
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(38, 53, 110, 1),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(width, height),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: icon,
                ),
              ),
              TextSpan(
                text: text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}
