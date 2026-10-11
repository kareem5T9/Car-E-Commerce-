import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/screens/add_product.dart';
import 'package:ecommarce_project/screens/home.dart';
import 'package:ecommarce_project/screens/profile.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar();

  @override
  createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 0;

  final List<Widget> screens = [Home(), AddProduct(), Profile() ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.inputField,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGray,
        selectedFontSize: 15,
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 35),
            label: "Add",
          ),
        
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
