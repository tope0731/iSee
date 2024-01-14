import 'package:final_ito/auth/auth_page.dart';
import 'package:final_ito/components/appbar.dart';
import 'package:final_ito/screens/home_screen.dart';
import 'package:final_ito/screens/login/forgot_password_page.dart';
import 'package:final_ito/screens/login/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.showRegisterPage});
  final VoidCallback showRegisterPage;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isTeacher = true;

  Future signIn() async {
    // Check if email and password are not empty before signing in
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      // Show an error message or handle it accordingly
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Enter Credentials',
      );
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => HomePageScreen(isTeacher)));
    } on FirebaseAuthException catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Invalid Credentials. Try Again',
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: apbar(context),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/finalLogo.png',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'WELCOME BACK',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF056FD0),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Sign to Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 150, 193, 233),
                    ),
                  ),
                ),
                const Gap(90),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Email',
                  ),
                ),
                const Gap(15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Color(0xFF1590f1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1590f1),
                      fixedSize: const Size(175, 50),
                    ),
                    onPressed: signIn,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: widget.showRegisterPage,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Register now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
