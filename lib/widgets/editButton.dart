import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomEditButton extends HookWidget {
  final Function() onSave;
  final Function() onEdit;
  var isEditing = useState(false);
  final double size;

  CustomEditButton({
    required this.onSave,
    required this.onEdit,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 38, 53, 110),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: () {
          isEditing.value = !isEditing.value;
          isEditing.value ? onSave() : onEdit();
        },
        icon: FittedBox(
          fit: BoxFit.cover,
          child: Icon(
            isEditing.value ? Icons.done : Icons.edit,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
