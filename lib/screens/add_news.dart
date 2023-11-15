import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  TextEditingController title = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void> uploadPhoto(File imageFile) async {
    final storage = FirebaseStorage.instance.ref().child(
        '${DateTime.now().millisecondsSinceEpoch}.${imageFile.path.split('.').last}');
    await storage.putFile(imageFile);
    image.text = await storage.getDownloadURL();
  }

  Future<void> uploadNews() async {
    await FirebaseFirestore.instance.collection('published news').add({
      'image': image.text,
      'title': title.text,
      'description': description.text,
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: 'title'),
            ),
            TextField(
              controller: description,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'descrition'),
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
// Pick an image.
                final XFile? xFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (xFile != null) {
                  await uploadPhoto(File(xFile.path));
                }
              },
              child: Text('Upload Image'),
            ),
            ElevatedButton(
              onPressed: () async {
                await uploadNews(); // You can handle image upload here
                Navigator.of(context)
                    .pop(); // Navigate back to the profile screen
              },
              child: Text('Upload News'),
            ),
          ],
        ),
      ),
    );
  }
}
