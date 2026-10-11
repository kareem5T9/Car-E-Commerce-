 import'package:ecommarce_project/appColors/colors.dart';
import 'package:flutter/material.dart';



// ignore: must_be_immutable
class CustomSmallButton extends StatefulWidget {
  String? text;
  VoidCallback? onPressed;

  CustomSmallButton({this.text,this.onPressed});

  @override
  createState() => _CustomSmallButtonState();
}

class _CustomSmallButtonState extends State<CustomSmallButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
     onPressed: widget.onPressed ?? () {},
      child: Text( "${widget.text}",
        style: TextStyle( color: AppColors.primary,  fontSize: 28,  fontWeight: FontWeight.bold,),
      ),
    );
  }
}
