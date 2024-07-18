
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  XFile? _pickedImage;
  TextEditingController captionController = TextEditingController();

  Future<void> _imagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
      });
    }
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    if (_pickedImage == null) return;

    try {
      final fileBytes = await _pickedImage!.readAsBytes();
      final fileName = _pickedImage!.name;

      final Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      final UploadTask uploadTask = storageReference.putData(fileBytes);

      await uploadTask.whenComplete(() => null);
      final imageUrl = await storageReference.getDownloadURL();
      print("Image uploaded to: $imageUrl");
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _imagePicker,
              child: const Text('Pick an Image'),
            ),
            Text(
              _pickedImage != null ? _pickedImage!.name : 'No image selected',
            ),
            ElevatedButton(
              onPressed: _uploadImageToFirebaseStorage,
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
