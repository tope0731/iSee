import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SwitchAccount2 extends StatefulWidget {
  const SwitchAccount2({super.key});

  @override
  State<SwitchAccount2> createState() => _SwitchAccount2State();
}

class _SwitchAccount2State extends State<SwitchAccount2> {
  var collection = FirebaseFirestore.instance.collection('users');
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;
  final _auth = FirebaseAuth.instance;

  _incrementCounter() async {
    List<Map<String, dynamic>> tempList = [];
    User user = _auth.currentUser!;
    var data = await collection.get();

    await Future.wait(data.docs.map((element) async {
      if (element.id == user.uid) {
        var subcollection = element.reference.collection('profiles');
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

  // void getData() async {
  //   List<Map<String, dynamic>> tempList = [];
  //   User user = _auth.currentUser!;
  //   _uid = user.uid;
  //   print('User email ${user.email}');
  //   final DocumentSnapshot userDoc =
  //       await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  //   _name = userDoc.get('first name');

  //   setState(() {});
  //   //print('User name: $_name');
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    bool isTeacher = false;
    return SafeArea(
      child: Scaffold(
        body: isLoaded
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  print(isTeacher);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePageScreen(isTeacher),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(items[index]['first name'] ?? 'not given'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(items[index]['last name'] ?? 'not given'),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Text('no data'),
      ),
    );
  }
}
