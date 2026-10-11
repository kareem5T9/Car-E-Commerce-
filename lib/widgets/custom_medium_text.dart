import 'package:ecommarce_project/appColors/colors.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomMediumText extends StatelessWidget {
  String? text;

  CustomMediumText({required this.text,});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,

      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
    );
  }
}
