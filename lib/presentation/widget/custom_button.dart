import 'package:flutter/material.dart';

import '../styles/colors.dart';
class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color ?color;

  const CustomButton({required this.title, required this.onPressed,this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 61,
        width: 140,
        decoration:  BoxDecoration(
          color: color??AppColor.blue,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
