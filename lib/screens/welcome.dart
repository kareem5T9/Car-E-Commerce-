import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/screens/login.dart';
import 'package:ecommarce_project/screens/register.dart';
import 'package:ecommarce_project/widgets/custom_Button.dart';
import 'package:ecommarce_project/widgets/custom_Header_Text.dart';
import 'package:ecommarce_project/widgets/custom_small_text.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/welcome.jpg", fit: BoxFit.cover),

          Container(color: Color.fromARGB(40, 0, 0, 210)),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomHeaderText(text: "Drive Your Dreams"),

              SizedBox(height: 8),
              CustomSmallText(text:"Find the perfect car for you.",),
            
              SizedBox(height: 50),

              CustomButton(
                text: "Sign UP",
                backgroundColor: AppColors.primary,
                icon: Icons.group_add,
                iconColor: AppColors.textWhite,
                borderRadius: 12,
                width: 400,
                height: 60,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
              ),
              SizedBox(height: 25),
              CustomButton(
                text: "Login",
                backgroundColor: AppColors.textDark,
                icon: Icons.login,
                iconColor: AppColors.textWhite,
                borderRadius: 12,
                width: 400,
                height: 60,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
              SizedBox(height: 120),
            ],
          ),
        ],
      ),
    );
  }
}
