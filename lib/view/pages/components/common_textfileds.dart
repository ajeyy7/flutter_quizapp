import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String labelText;
  final void Function(String)? onChanged;
  const CommonTextField({super.key, required this.labelText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
