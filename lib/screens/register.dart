import 'package:ecommarce_project/appColors/colors.dart';
import 'package:ecommarce_project/screens/login.dart';
import 'package:ecommarce_project/screens/welcome.dart';
import 'package:ecommarce_project/services/auth_services.dart';
import 'package:ecommarce_project/widgets/custom_Button.dart';
import 'package:ecommarce_project/widgets/custom_inputField.dart';
import 'package:ecommarce_project/widgets/custom_medium_text.dart';
import 'package:ecommarce_project/widgets/custom_small_Button.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register();

  @override
  createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  AuthServices _authServices = AuthServices();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

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
        title: CustomMediumText(text: "Sign Up"),
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
                  value: "Name",
                  controller: _nameController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    }
                    return null;
                  },
                ),
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

                CustomInputfield(
                  value: "confirm password",
                  controller: _confirmpasswordController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "الحقل فارغ يرجى ادخال قيمة";
                    } else if (v != _passwordController.text) {
                      return " كلمة السر غير متطابقة";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 35),

                CustomButton(
                  text: "SignUP",
                  borderRadius: 12,
                  backgroundColor: AppColors.primary,
                  width: 400,
                  height: 60,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String message = await _authServices.signUp(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );

                      if (message.contains("تم التسجيل")) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomMediumText(text: message),
                            
                            backgroundColor: Colors.green,
                          ),
                        );

                        _nameController.clear();
                        _emailController.clear();
                        _passwordController.clear();
                        _confirmpasswordController.clear();
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

                SizedBox(height: 35),

                CustomMediumText(text: "هل لديك حساب بالفعل ؟"),
                CustomSmallButton(
                  text: "تسجيل دخول",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
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
