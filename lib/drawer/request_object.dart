import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

void main() {
  runApp(ImagePickerApp());
}

class ImagePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  String? _objectName;
  TextEditingController _objectNameController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      setState(() {
        _imageFile = File(pickedImage.path);
      });
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _submit() {
    String objectName = _objectNameController.text;

    // Perform actions with objectName and _imageFile here
    // For example, upload to a server or process locally

    // Store the object name and clear the text field
    setState(() {
      _objectName = objectName;
      _objectNameController.clear();
    });

    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: 'Thank You For Your Suggestion!',
      text: 'Your suggestion is still under review.',
    );
  }

  void _cancel() {
    // Clear the text field and reset the image on cancel
    setState(() {
      _objectNameController.clear();
      _imageFile = null;
      _objectName = null;
    });
  }

  @override
  void dispose() {
    _objectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Center(
          child: Text(
            'Objects',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFF0C6699),
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        'No image selected',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
              child: Text('Select Image from Gallery'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _objectNameController,
              decoration: InputDecoration(
                labelText: 'Object Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _submit,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  ),
                  child: Text('Submit'),
                ),
                OutlinedButton(
                  onPressed: _cancel,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
            if (_imageFile != null && _objectName != null)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Image:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.file(
                    _imageFile!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Object Name: $_objectName',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
