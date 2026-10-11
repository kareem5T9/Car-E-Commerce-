import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/screens/welcome.dart';
import 'package:ecommarce_project/services/auth_services.dart';
import 'package:ecommarce_project/widgets/custom_Button.dart';
import 'package:ecommarce_project/widgets/custom_header_text.dart';
import 'package:ecommarce_project/widgets/custom_medium_text.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthServices _authServices = AuthServices();
  late String email;

  @override
  void initState() {
    super.initState();
    email = _authServices.currentUser?.email ?? "غير معروف";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: CustomHeaderText(text: "Profile"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle, size: 120, color: AppColors.textWhite),
              SizedBox(height: 20),
              CustomMediumText(text:"Email:",),
              SizedBox(height: 10),
              CustomMediumText(text: email),
              SizedBox(height: 50),
              CustomButton(
                text: "Log Out",
                borderRadius: 12,
                backgroundColor: AppColors.primary,
                width: 250,
                height: 60,
                icon: Icons.logout,
                iconColor: AppColors.textWhite,
                onPressed: () async {
                  String message = await _authServices.signOut();

                  if (message.contains("تم تسجيل الخروج")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomMediumText(text: message),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Welcome()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomMediumText(text: message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
