import 'package:final_ito/auth/auth_page.dart';
import 'package:final_ito/screens/home_screen.dart';
import 'package:final_ito/screens/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTeacher = true;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePageScreen(isTeacher);
          } else {
            return onBoardingScreen();
          }
        },
      ),
    );
  }
}
