import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Color? color;
  final void Function() onTap;
  final Color? textColor;
  final double? width;
  final double? height;
  final String text;
  const CommonButton(
      {super.key,
      this.color,
      required this.text,
      this.textColor,
      this.width,
      this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 250,
        height: height ?? 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor ),
          ),
        ),
      ),
    );
  }
}
