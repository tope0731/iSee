import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ito/components/appbar.dart';
import 'package:final_ito/components/drawer.dart';
import 'package:final_ito/components/student_drawer.dart';
import 'package:final_ito/screens/game/choose_game.dart';
import 'package:final_ito/screens/onboarding/onboarding.dart';
import 'package:final_ito/screens/scanner/camera_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class StudentHomePageScreen extends StatefulWidget {
  StudentHomePageScreen({super.key});

  @override
  State<StudentHomePageScreen> createState() => _StudentHomePageScreenState();
}

class _StudentHomePageScreenState extends State<StudentHomePageScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    //print(docIDs);
    //print('line 36666 ${user.uid}');
    return SafeArea(
      child: Scaffold(
        // appBar: apbar(context),
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF60bbcf),
              size: 45,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                  icon: Icon(Icons.widgets),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                  iconSize: 45,
                  color: Color(0xFF60bbcf)),
            ),
          ],
        ),
        endDrawer: const drawerStudent(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 140),
                Image.asset(
                  'assets/images/finalLogo.png',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to iSee',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '"Explore, Imagine, Discover: Pixel Playtime - Where pictures come to life, just for kids!"',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const CameraScreen(),
                      ),
                    );
                  },
                  child: SimpleShadow(
                    opacity: 0.3,
                    color: Colors.black,
                    offset: const Offset(3, 4),
                    sigma: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/explore_btn.png',
                        height: 100,
                        width: 320,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => Games(),
                      ),
                    );
                  },
                  child: SimpleShadow(
                    opacity: 0.3,
                    color: Colors.black,
                    offset: const Offset(3, 4),
                    sigma: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/game_btn.png',
                        height: 100,
                        width: 320,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
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
