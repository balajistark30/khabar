import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentUsername;
  final String currentBio;
  final Function(String, String, String)
      onSaveProfile; // Callback to save profile changes

  EditProfileScreen({
    required this.currentUsername,
    required this.currentBio,
    required this.onSaveProfile,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  final users = FirebaseFirestore.instance.collection("user");
  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.currentUsername;
    _bioController.text = widget.currentBio;
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
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Save the changes and update the profile
                String newUsername = _usernameController.text;
                String newBio = _bioController.text;
                FirebaseAuth.instance.currentUser
                    ?.updateDisplayName(newUsername);

                String userId = FirebaseAuth.instance.currentUser!.uid;
                final user = <String, dynamic>{"userId": userId, 'bio': newBio};

                final details =
                    await users.where('userId', isEqualTo: userId).get();

                if (details.docs.isEmpty) {
                  users.add(user).then((DocumentReference doc) =>
                      print('DocumentSnapshot added with ID: ${doc.id}'));
                } else {
                  users.doc(details.docs.first.id).update(user);
                }

                widget.onSaveProfile(newUsername, newBio,
                    ''); // You can handle image upload here
                Navigator.of(context)
                    .pop(); // Navigate back to the profile screen
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
