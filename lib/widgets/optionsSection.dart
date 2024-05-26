import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './optionButton.dart';

class OptionsSection extends HookWidget {
  final List<OptionButton> options;

  OptionsSection({
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color.fromRGBO(162, 162, 162, 1),
            width: 1,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              children: options.map((option) {
            return Column(
              children: [
                option,
                SizedBox(height: 10),
              ],
            );
          }).toList()),
        ],
      ),
    );
  }
}
