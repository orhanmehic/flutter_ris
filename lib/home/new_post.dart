
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data'; // Import for reading image bytes
import 'package:firebase_storage/firebase_storage.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  XFile? _pickedImage;
  TextEditingController captionController = TextEditingController();
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
  }

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
    var metadata = SettableMetadata(
      contentType: 'image/jpg',
    );

    if (_pickedImage == null) return;

    try {
      final fileBytes = await _pickedImage!.readAsBytes();
      final fileName = _pickedImage!.name;

      final Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      final UploadTask uploadTask = storageReference.putData(fileBytes, metadata);

      await uploadTask.whenComplete(() => null);
      final imageUrl = await storageReference.getDownloadURL();
      print("Image uploaded to: $imageUrl");

      // Save post details in the database
      _savePostDetails(imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _savePostDetails(String imageUrl) async {
    final caption = captionController.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.13:3003/api/posts/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'caption': caption,
          'imageUrl': imageUrl,
        }),
      );

      if (response.statusCode == 201) {
        print('Post saved successfully');
        Navigator.pop(context); // Go back to the previous screen
      } else {
        throw Exception('Failed to save post');
      }
    } catch (e) {
      print('Error saving post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Post', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a caption:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: 'Write your caption here...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    _pickedImage != null
                        ? Image.network(
                            _pickedImage!.path,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _imagePicker,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Pick an Image'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        textStyle: const TextStyle(fontSize: 16),
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _uploadImageToFirebaseStorage,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Upload Post'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Colors.greenAccent[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

