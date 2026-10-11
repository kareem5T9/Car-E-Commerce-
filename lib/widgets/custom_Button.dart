import 'package:ecommarce_project/appColors/colors.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  String? text;
  IconData? icon;
  Color? iconColor;
  Color? backgroundColor;
  double borderRadius;
  VoidCallback? onPressed;
  double  height;
  double  width;

  CustomButton({
    required this.text,
    this.icon,
    this.iconColor,
     this.backgroundColor,
   required this.borderRadius,
    this.onPressed,
    required  this.height,
    required  this.width
  });

  @override
  createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed ?? () {},

      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
        fixedSize: WidgetStatePropertyAll(Size(widget.width, widget.height)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.text}",
            style:  TextStyle( color: AppColors.textWhite, fontSize: 27, fontWeight: FontWeight.bold, ),
          ),

          Icon( widget.icon, color: widget.iconColor , size: 27, ),
        ],
      ),
    );
  }
}
