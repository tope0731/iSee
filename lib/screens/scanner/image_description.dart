import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/components/object.dart';
import 'package:final_ito/screens/home_screen.dart';
import 'package:final_ito/screens/scanner/camera_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:math';

class ObjectDescription extends StatefulWidget {
  ObjectDescription(this.file, this.label, this.confidence, this.pickedImage,
      {super.key});
  File pickedImage;
  XFile file;
  var label;
  var confidence;

  @override
  State<ObjectDescription> createState() => _ObjectDescriptionState();
}

class _ObjectDescriptionState extends State<ObjectDescription> {
  final _auth = FirebaseAuth.instance;
  String _uid = '';
  String _name = '';
  int randomNum = 0;

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
    bool isTeacher = true;
    XFile files = XFile(widget.file.path);
    // _pickedImage = picture
    File picture = File(widget.file.path);
    File pickedImage = File(widget.pickedImage.path);
    String label = widget.label;
    int object = 0;
    String url;

    if (widget.label == 'BAG') {
      object = 0;
    } else if (widget.label == 'BOOK') {
      object = 1;
    } else if (widget.label == 'CHAIR') {
      object = 2;
    } else if (widget.label == 'RULER') {
      object = 3;
    } else if (widget.label == 'PENCIL') {
      object = 4;
    } else if (widget.label == 'NOTEBOOK') {
      object = 5;
    } else if (widget.label == 'CRAYONS') {
      object = 6;
    } else if (widget.label == 'ERASER') {
      object = 7;
    } else if (widget.label == 'SHOES') {
      object = 8;
    } else if (widget.label == 'SCISSORS') {
      object = 9;
    }
    int random() {
      Random random = new Random();
      int randomNumber = random.nextInt(10000);

      return randomNumber;
    }

    void insertImage() async {
      try {
        String imageName = random().toString();
        final ref = FirebaseStorage.instance
            .ref()
            .child('scannedObject')
            .child('$imageName.jpg');
        await ref.putFile(pickedImage);

        url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .collection('scanned object')
            .add({
          'scanned object': url,
          'label': label,
        }).then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePageScreen(isTeacher),
                  ),
                ));
      } catch (error) {
        print('error occured ${error}');
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF3056dd),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => HomePageScreen(isTeacher),
                  ),
                );
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
            ),
            const Gap(8),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Color(0xFFfdfdfd)),
              child: Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.label,
                                style: const TextStyle(
                                    fontSize: 45, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF89CFF3), width: 4),
                            ),
                            height: 198,
                            width: 115,
                            child: Image.file(
                              pickedImage,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      const Gap(30),
                      const Text(
                        'Definition',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        objectData[object]['description'].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Gap(60),
                      const Text(
                        'Examples',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const Gap(10),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF3056dd),
                          child: Text('1'),
                        ),
                        title: Text(objectData[object]['s1'].toString()),
                      ),
                      const Gap(10),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF3056dd),
                          child: Text('2'),
                        ),
                        title: Text(objectData[object]['s2'].toString()),
                      ),
                      const Gap(10),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF3056dd),
                          child: Text('3'),
                        ),
                        title: Text(objectData[object]['s3'].toString()),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CameraScreen()));
                            },
                            child: Text('Try Again'),
                          ),
                          ElevatedButton(
                            onPressed: insertImage,
                            child: Text('Continue'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
