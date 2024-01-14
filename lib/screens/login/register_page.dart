import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.showLoginPage});
  final VoidCallback showLoginPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future signUp() async {
    bool flag = false;
    final isValid = _formKey.currentState?.validate();
    if (passwordConfirmed()) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Register successfully!',
        text: 'Login Now',
      );
      try {
        if (isValid != null) {
          _formKey.currentState?.save();
//create user
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

          //add user details
          // addUserDetails(
          //   _firstNameController.text.trim(),
          //   _lastNameController.text.trim(),
          //   _emailController.text.trim(),
          //   int.parse(
          //     _ageController.text.trim(),
          //   ),
          // );
          final User? user = _auth.currentUser;
          final _uid = user?.uid;
          user!.reload();
          await FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'first name': _firstNameController.text.trim(),
            'last name': _lastNameController.text.trim(),
            'email': _emailController.text.trim(),
            'age': int.parse(_ageController.text.trim()),
            'role': 'teacher',
          });

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AuthPage()));
        }
      } catch (error) {
        print('This is a fucking error $error');
      }
    }
  }

  // Future addUserDetails(
  //     String firstName, String lastName, String email, int age) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'first name': firstName,
  //     'last name': lastName,
  //     'age': age,
  //     'email': email,
  //   });
  // }

  bool passwordConfirmed() {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF056FD0),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 150, 193, 233),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          hintText: 'Enter First Name',
                        ),
                      ),
                      Gap(15),
                      TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                          hintText: 'Enter Last Name',
                        ),
                      ),
                      Gap(15),
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
                        controller: _ageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Age',
                          hintText: 'Enter Age',
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
                      const Gap(15),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          hintText: 'Enter Confirm Password',
                        ),
                      ),
                      const Gap(20),
                      Container(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF1590f1),
                            fixedSize: const Size(175, 50),
                          ),
                          onPressed: signUp,
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Login now',
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
