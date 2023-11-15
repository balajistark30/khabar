import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khabar/views/home.dart';

class PublishedNews extends StatefulWidget {
  const PublishedNews({super.key});

  @override
  State<PublishedNews> createState() => _PublishedNewsState();
}

class _PublishedNewsState extends State<PublishedNews> {
  final Stream<QuerySnapshot> _newsStream = FirebaseFirestore.instance
      .collection('published news')
      .orderBy('createdAt', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Kha',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'bar',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: _newsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return BlogTile(
                    title: data['title'],
                    imageUrl: data['image'],
                    desc: data['description'],
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
