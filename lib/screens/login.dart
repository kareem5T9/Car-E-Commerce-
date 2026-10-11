import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/layout/Custom_Navigation_bar.dart';
import 'package:ecommarce_project/screens/register.dart';
import 'package:ecommarce_project/screens/welcome.dart';
import 'package:ecommarce_project/widgets/custom_Button.dart';
import 'package:ecommarce_project/widgets/custom_inputField.dart';
import 'package:ecommarce_project/widgets/custom_medium_text.dart';
import 'package:ecommarce_project/widgets/custom_small_Button.dart';
import 'package:flutter/material.dart';
import 'package:ecommarce_project/services/auth_services.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Welcome()),
            );
          },
          icon: Icon(Icons.arrow_back, color: AppColors.textWhite, size: 35),
        ),
        centerTitle: true,
        title:CustomMediumText(text: "Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 35),
                CustomInputfield(
                  value: "email",
                  controller: _emailController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else if (!v.contains("@gmail.com")) {
                      return "الايميل غير صالح";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 35),
                CustomInputfield(
                  value: "password",
                  controller: _passwordController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else if (v.length < 6) {
                      return "كلمة السر أقل من 6 ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 35),
                CustomMediumText(text: "لا تمتلك حساب "),
                CustomSmallButton(
                  text: " إنشاء حساب ",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                ),
                SizedBox(height: 5),
                CustomButton(
                  text: "Login",
                  borderRadius: 12,
                  backgroundColor: AppColors.primary,
                  width: 400,
                  height: 60,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String message = await _authServices.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );

                      if (message.contains("تم تسجيل الدخول")) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomMediumText(text: message),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomNavigationBar(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomMediumText(text: message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
