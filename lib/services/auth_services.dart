

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String> signUp(String email, String password) async {
    try {
       await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "تم التسجيل بنجاح ";
    } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
        return "البريد الإلكتروني مستخدم مسبقًا";
      } else {
        return "خطأ غير متوقع: ${e.message}";
      }
    } 
  }


 Future<String> login(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );
    return "تم تسجيل الدخول بنجاح";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-credential') {
      return "بيانات التسجيل غلط تأكد من بياناتك ثم أعد المحاولة";
    } else {
      return "فشل تسجيل الدخول ";
    }
  }
}




  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "تم تسجيل الخروج بنجاح";
    } catch (e) {
      return "خطأ أثناء تسجيل الخروج: ";
    }
  }

  
  User? get currentUser {
    return _auth.currentUser;
  }
}
