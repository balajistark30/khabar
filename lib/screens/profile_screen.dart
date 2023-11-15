import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khabar/screens/add_news.dart';

import 'edit_profile_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = FirebaseAuth.instance.currentUser?.displayName ??
      "Your Username"; // Initialize with a default value
  String? bio;

  Future<void> getBio() async {
    final details = await FirebaseFirestore.instance
        .collection('user')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (details.docs.isEmpty) {
      bio = 'Add your bio';
    } else {
      bio = details.docs.first.data()['bio'];
    }

    setState(() {});
  }

  @override
  void initState() {
    getBio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Add your logout logic here
                // Navigate to the login screen
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(), // Replace with your login screen widget
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: 'logout',
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.red,
                backgroundImage: AssetImage('assets/balaji.webp'),
              ),
              Container(
                height: 100,
                width: 200,
                child: Column(
                  children: [
                    Text(
                      'Bio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    bio == null
                        ? const CircularProgressIndicator()
                        : Text(
                            bio!,
                            maxLines: 3, // Set the maximum number of lines
                            overflow: TextOverflow
                                .ellipsis, // Handle overflow with an ellipsis
                          ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Posts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('123'), // Replace with your post count.
                ],
              ),
              Column(
                children: [
                  Text(
                    'Followers',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('456k'), // Replace with your followers count.
                ],
              ),
              Column(
                children: [
                  Text(
                    'Following',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('789'), // Replace with your following count.
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: bio == null
                    ? () => Fluttertoast.showToast(msg: 'Update your bio')
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              currentUsername:
                                  username, // Pass the current username
                              currentBio: bio!, // Pass the current bio
                              onSaveProfile:
                                  (newUsername, newBio, newProfileImage) {
                                // Handle saving the profile changes here
                                setState(() {
                                  username =
                                      newUsername; // Update the username in the state
                                  bio = newBio; // Update the bio in the state
                                });
                              },
                            ),
                          ),
                        ); // Add logic for editing the profile
                      },
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add logic for adding news
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNews(),
                    ),
                  ); // Add
                },
                child: Text(
                  'Add News',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
