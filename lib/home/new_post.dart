

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {

  @override 
  _NewPostState  createState() => _NewPostState();
}

class _NewPostState extends State<NewPost>{

  XFile? _pickedImage;
  TextEditingController captionController = TextEditingController();

  Future<XFile?> _imagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage=pickedFile;
      });
    } else {
      return null;
    }
  }


  /*Future<void> addPost() async {
    // Upload image to Firebase Storage
    final imageUrl = await _uploadImageToFirebaseStorage();

    // Send post information (including image URL) to MySQL database
    final postInfo = {
      'caption': captionController.text,
      'imageUrl': imageUrl,
    };
    final response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'), // Replace with your API endpoint
      body: postInfo,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      
    } else {
      
    }
  }
  */
  Future<void> _uploadImageToFirebaseStorage() async {
    //if (_pickedImage == null) return null;

    try {
      final file = File(_pickedImage!.path);
      final fileName = file.path.split('/').last;

      final Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      final UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() => null);

      //final imageUrl = await storageReference.getDownloadURL();
      print("uploadovano");
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Post'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              
              controller: captionController,
              decoration: const InputDecoration(
                hintText: 'Add a caption',
                
              ),
            ),
            ElevatedButton(
              onPressed: () => _imagePicker(), // Call _imagePicker on button press
              child: const Text('Pick an Image'),
            ),
            Text(_pickedImage != null
            ? _pickedImage!.name
            : 'No image selected'
            ),
            ElevatedButton(
              onPressed: () => _uploadImageToFirebaseStorage(),
             child: Text('uploadaj') )
          ],
        ),
      ),
    );
    // TODO: implement build
  }
}
