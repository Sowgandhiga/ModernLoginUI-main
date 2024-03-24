import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/firstpage.dart';
import 'package:modernlogintute/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modernlogintute/pages/login_page.dart';
import 'package:modernlogintute/pages/loginreg.dart';

class AuthMail extends StatelessWidget {
  const AuthMail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return FirstPage();
            }
          }),
    );
  }
}
