import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/auth/auth_page.dart';
import 'package:final_ito/auth/main_page.dart';
import 'package:final_ito/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

class RegisterStudentPage extends StatefulWidget {
  const RegisterStudentPage({super.key});

  @override
  State<RegisterStudentPage> createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  bool isTeacher = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _uid = '';
  String _name = '';

  @override
  void dispose() {
    // TODO: implement dispos
    _firstNameController.dispose();
    _lastNameController.dispose();

    super.dispose();
  }

  Future signUp() async {
    bool flag = true;
    final isValid = _formKey.currentState?.validate();
    if (flag) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Register successfully!',
        text: 'Login Now',
      );
      try {
        if (isValid != null) {
          _formKey.currentState?.save();
          final User? user = _auth.currentUser;
          final _uid = user?.uid;

          user!.reload();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .collection('profiles')
              .add({
            'first name': _firstNameController.text.trim(),
            'last name': _lastNameController.text.trim(),
            'address': _addressController.text.trim(),
            'role': 'student',
          });

          Navigator.push(context,
              MaterialPageRoute(builder: (_) => HomePageScreen(isTeacher)));
        }
      } catch (error) {
        print('This is a fucking error $error');
      }
    }
  }

  // void getData() async {
  //   User user = _auth.currentUser!;
  //   _uid = user.uid;
  //   print('User email ${user.email}');
  //   final DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(_uid)
  //       .collection('profiles')
  //       .doc('3pm2YiqoNCp75BmvFqM8')
  //       .get();
  //   _name = userDoc.get('studentName');
  //   setState(() {});
  //   print('User name: $_name');
  // }

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
                        controller: _addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                          hintText: 'Enter Address',
                        ),
                      ),
                      // Gap(15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Text(
                      //         "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}"),
                      //     ElevatedButton(
                      //         onPressed: () async {
                      //           final DateTime? dateTime = await showDatePicker(
                      //               context: context,
                      //               initialDate: selectedDate,
                      //               firstDate: DateTime(2000),
                      //               lastDate: DateTime.now());
                      //           if (dateTime != null) {
                      //             setState(() {
                      //               print('datetime not null');
                      //               selectedDate = dateTime;
                      //               print(selectedDate);
                      //             });
                      //           }
                      //         },
                      //         child: Text('Choose Date')),
                      //   ],
                      // ),
                      Gap(15),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
