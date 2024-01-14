import 'package:final_ito/components/object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectList extends StatefulWidget {
  const ObjectList({Key? key}) : super(key: key);

  @override
  State<ObjectList> createState() => _ObjectListState();
}

class _ObjectListState extends State<ObjectList> {
  int tappedIndex = -1;

  void showAlertDialog() {
    if (tappedIndex != -1) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: [
                Text(
                  '${objectData[tappedIndex]['name']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height:
                        8), // Adjust the height according to your preference
                Text(
                  '${objectData[tappedIndex]['description']}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            content: Image.asset(
              'assets/images/${objectData[tappedIndex]['image'].toString()}',
            ),
            actions: [
              CupertinoDialogAction(
                child: Text("Continue"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFC3EEFF),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            ),
          ),
          title: const Center(
            child: Text(
              'Objects',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF0C6699),
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: false,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: objectData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        tappedIndex = index;
                      });
                      showAlertDialog(); // Call the function to show the dialog
                    },
                    child: Card(
                      key: ValueKey<int>(index),
                      color: Colors.transparent,
                      elevation: 20,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 220,
                              width: 350,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/${objectData[index]['imgName'].toString()}',
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.white.withOpacity(0.8),
                              child: Text(
                                objectData[index]['name'].toString(),
                                style: const TextStyle(
                                  color: Color(0xFF0C6699),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign:
                                    TextAlign.center, // Center align text
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
