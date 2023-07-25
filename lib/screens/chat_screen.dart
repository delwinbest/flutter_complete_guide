import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chat'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
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
