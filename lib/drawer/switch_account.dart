import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/drawer/list_of_object.dart';
import 'package:final_ito/screens/home_screen.dart';
import 'package:final_ito/screens/student/add_student.dart';
import 'package:final_ito/screens/student/multiple_student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({super.key});

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  final _auth = FirebaseAuth.instance;
  String _uid = '';
  String _name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Center(
          child: Text(
            'Switch Account',
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          scrollDirection: Axis.vertical,
          children: [
            GridTile(
              child: Image.asset('assets/images/USER1.png'),
              footer: Center(
                child: Text(
                  'USER1',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GridTile(
              child: Image.asset('assets/images/USER2.png'),
              footer: Center(
                child: Text(
                  'USER2',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            GridTile(
              child: Image.asset('assets/images/USER3.png'),
              footer: Center(
                child: Text(
                  'USER3',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GridTile(
              child: Image.asset('assets/images/USER4.png'),
              footer: Center(
                child: Text(
                  'USER4',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GridTile(
              child: Image.asset('assets/images/USER5.png'),
              footer: Center(
                child: Text(
                  'USER5',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegisterStudentPage(),
                  ),
                );
              },
              child: GridTile(
                child: Image.asset('assets/images/USER6.png'),
                footer: Center(
                  child: Text(
                    'Add Student',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
