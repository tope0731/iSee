import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/auth/auth_page.dart';
import 'package:final_ito/drawer/list_of_object.dart';
import 'package:final_ito/drawer/profile.dart';
import 'package:final_ito/drawer/request_object.dart';
import 'package:final_ito/drawer/students.dart';
import 'package:final_ito/drawer/switch_a.dart';
import 'package:final_ito/drawer/switch_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  final _auth = FirebaseAuth.instance;
  String _uid = '';
  String _name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    User user = _auth.currentUser!;
    _uid = user.uid;
    print('User email ${user.email}');
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    _name = userDoc.get('first name');
    setState(() {});
    //print('User name: $_name');
  }

  @override
  Widget build(BuildContext context) {
    //print('Inside build name: $_name');
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: const Color(0xFF0C6699)),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Welcome, $_name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          buildListTile(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => ProfileUI()),
              );
            },
          ),
          buildListTile(
            icon: Icons.person,
            title: 'Students',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => Student()),
              );
            },
          ),
          buildListTile(
            icon: Icons.list,
            title: 'List of Objects',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => ObjectList()),
              );
            },
          ),
          buildListTile(
            icon: Icons.request_page,
            title: 'Request Object',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => ImagePickerScreen()),
              );
            },
          ),
          buildListTile(
            icon: Icons.request_page,
            title: 'Switch account',
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => SwitchAccount()),
              );
            },
          ),
          buildListTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (_) => AuthPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      onTap: onTap,
      title: Text(title),
    );
  }
}
