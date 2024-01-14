import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/components/appbar.dart';
import 'package:final_ito/screens/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  State<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  final _auth = FirebaseAuth.instance;
  String _uid = '';
  String _name = '';
  File? _pickedImage;
  var collection = FirebaseFirestore.instance.collection('users');
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _incrementCounter();
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

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    print(_pickedImage);
  }

  _incrementCounter() async {
    List<Map<String, dynamic>> tempList = [];
    User user = _auth.currentUser!;
    var data = await collection.get();

    await Future.wait(data.docs.map((element) async {
      if (element.id == user.uid) {
        var subcollection = element.reference.collection('scanned object');
        var subcollectionData = await subcollection.get();

        subcollectionData.docs.forEach((subElement) {
          tempList.add(subElement.data());
        });
      }
    }));

    setState(() {
      items = tempList;
      isLoaded = true;
    });

    print(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C6699),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFC3EEFF),
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFFC3EEFF),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFC3EEFF),
      body: Center(
        child: isLoaded
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                        items[index]['scanned object'] ?? 'not given'),
                    title: Row(
                      children: [
                        Text(items[index]['label'] ?? 'not given'),
                      ],
                    ),
                  );
                },
              )
            : Text('no data'),
      ),
    );
  }
}
