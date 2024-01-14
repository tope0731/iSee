import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _image; // Provide a default value of null

  Future<void> _getImage() async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _uploadImage() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference = storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(File(_image!.path));

      await uploadTask.whenComplete(() => print('Image uploaded'));

      String downloadURL = await storageReference.getDownloadURL();
      print('Download URL: $downloadURL');

      // Now you can save the downloadURL to Firestore or wherever you need it
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                color: Colors.grey.shade200,
                child: _image == null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Choose from Gallery'),
                        ),
                        IconButton(
                          onPressed: (){
                            _getImage();
                          }, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade300)
                          ),
                          icon: Icon(Icons.camera_alt,
                            size: 50,
                          ),
                        )
                      ],
                    )
                    : Image.file(
                        File(_image!.path),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
              ),
              ElevatedButton(
                onPressed: () {
                  _uploadImage();
                },
                child: Text('Save Profile'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
