import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return Scaffold(
            body: ListView.builder(
              itemBuilder: (ctx, index) => Container(
                padding: const EdgeInsets.all(8),
                child: const Text('This works'),
              ),
              itemCount: 10,
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('chats/9Xoe4YCSdtTArb9qs60z/messages')
                      .snapshots()
                      .listen((data) {
                    print(data);
                  });
                },
                child: const Icon(Icons.add)),
          );
        });
  }
}
