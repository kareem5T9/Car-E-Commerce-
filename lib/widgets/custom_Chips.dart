import 'package:ecommarce_project/appColors/colors.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String type;

    CustomChip({
    required this.type, 
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(type),
      backgroundColor: AppColors.inputField,
      labelStyle: TextStyle(
        color: AppColors.textWhite,
        fontSize: 20,
      ),
    );
  }
}
