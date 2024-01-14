import 'package:final_ito/auth/auth_page.dart';
import 'package:final_ito/components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  bool password() {
    if (_emailController.text.trim() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future passwordReset() async {
    try {
      if (password()) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Successful password reset!',
          text: 'We have sent a password reset instruction to your email.',
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Enter Credentials',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apbar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(30),
            const Text(
              'Enter your email and we will send you a reset link',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: passwordReset,
              child: const Text('Reset Password'),
            )
          ],
        ),
      ),
    );
  }
}
