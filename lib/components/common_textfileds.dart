import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const CommonTextField({super.key, required this.labelText, this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(color: Colors.black),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
