import 'package:ecommarce_project/layout/Custom_Navigation_bar.dart';
import 'package:ecommarce_project/screens/welcome.dart';
import 'package:ecommarce_project/services/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    AuthServices _authServices = AuthServices();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: _authServices.currentUser == null
          ?  Welcome()
          :  CustomNavigationBar(),
    );
  }
}
