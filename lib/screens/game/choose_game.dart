import 'package:final_ito/screens/game/game1.dart';
import 'package:final_ito/screens/game/game2.dart';
import 'package:final_ito/screens/game/game3.dart';
import 'package:final_ito/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Games extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isTeacher = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C6699),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => HomePageScreen(isTeacher)));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
          ),
        ),
        title: Text('Choose Game'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.displayMedium,
                  children: [
                    TextSpan(
                      text: "i",
                      style: GoogleFonts.inter(
                        fontSize: 65,
                        color: Color(0xFF163020),
                      ),
                    ),
                    TextSpan(
                      text: "See",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 65,
                        color: Color(0xFF163020),
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // Adjusted padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // Navigate to Screen A
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game1(),
                    ),
                  );
                },
                child: Text(
                  'Flip Card',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // Adjusted padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // Navigate to Screen B
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizScreen(), // Replace with your intended screen
                    ),
                  );
                },
                child: Text(
                  '4 pics 1 word',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // Adjusted padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // Navigate to Screen C
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuestionWidget(), // Replace with your intended screen
                    ),
                  );
                },
                child: Text(
                  'Quiz Time',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
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
