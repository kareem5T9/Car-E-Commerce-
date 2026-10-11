import 'package:ecommarce_project/appColors/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomHeaderText extends StatelessWidget {
  String? text;

  CustomHeaderText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
    );
  }
}
