import 'package:ecommarce_project/appColors/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInputfield extends StatefulWidget {
  String? value;
  TextEditingController? controller;
  String? Function(String?) validator;
  IconData? icon;

  CustomInputfield({
    required this.value,
    required this.controller,
    required this.validator,
    this.icon,
  });

  @override
  createState() => _CustomInputfieldState();
}

class _CustomInputfieldState extends State<CustomInputfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,

      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(widget.icon, size: 30, color: AppColors.textWhite),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: AppColors.inputField,
        hintText: "${widget.value}",
        label: Text(
          "${widget.value}",
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
