import 'package:camera/camera.dart';
import 'package:final_ito/auth/main_page.dart';
import 'package:final_ito/drawer/list_of_object.dart';
import 'package:final_ito/firebase_options.dart';
import 'package:final_ito/screens/game/game2.dart';
import 'package:final_ito/screens/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();

  runApp(const iSee());
}

class iSee extends StatelessWidget {
  const iSee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.blue, size: 50),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
