import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './editButton.dart';

class BigTextField extends HookWidget {
  final String fieldName;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final bool Function(String?) isValid;

  BigTextField({
    required this.fieldName,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final showPassword = useState(!isPassword);
    final text = useState(controller.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fieldName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1C1C),
              ),
            ),
            isValid(text.value)
                ? const Icon(CupertinoIcons.checkmark_alt_circle)
                : const Icon(
                    CupertinoIcons.clear_circled,
                  ),
          ],
        ),
        TextField(
          controller: controller,
          obscureText: isPassword && !showPassword.value,
          onChanged: (value) {
            text.value = value;
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: hintText,
            suffixIcon: isPassword
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      showPassword.value = !showPassword.value;
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class EditableTextField extends HookWidget {
  final String fieldName;
  final String hintText;
  final bool Function(String?) isValid;
  final void Function(Object) submitEdit;
  final String initialText;

  EditableTextField({
    required this.fieldName,
    required this.hintText,
    required this.isValid,
    required this.submitEdit,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    final isEditing = useState(true);
    final text = useState(this.initialText);

    return Row(
      children: [
        Container(
          width: 100,
          child: Text(
            fieldName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1C),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            child: TextField(
              enabled: !isEditing.value,
              onChanged: (value) {
                text.value = value;
              },
              decoration: InputDecoration(
                hintText: hintText,
                alignLabelWithHint: true,
              ),
            ),
          ),
        ),
        CustomEditButton(
          size: 35,
          onSave: () {
            isEditing.value = true;
            submitEdit(
              text.value,
            );
          },
          onEdit: () {
            isEditing.value = false;
          },
        )
      ],
    );
  }
}
