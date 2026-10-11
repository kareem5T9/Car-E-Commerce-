import 'package:ecommarce_project/appColors/colors.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomSmallText extends StatelessWidget {
  String? text;

   CustomSmallText({required this.text,});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,

      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
    );
  }
}
