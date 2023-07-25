import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chats/9Xoe4YCSdtTArb9qs60z/messages')
                .snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final documents = streamSnapshot.data!.docs;
              return ListView.builder(
                itemBuilder: (ctx, index) => Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(documents[index]['text'] as String),
                ),
                itemCount: streamSnapshot.data?.docs.length,
              );
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('chats/9Xoe4YCSdtTArb9qs60z/messages')
                  .add({'text': 'hehehe'});
            },
            child: const Icon(Icons.add)));
  }
}
