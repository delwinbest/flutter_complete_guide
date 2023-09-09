// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/auth_screet.dart';
import 'package:flutter_complete_guide/screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pink,
          background: Colors.pink,
          secondary: Colors.deepPurple,
        ),
      ),
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: ((context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print(snapshot);
            }
// Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return const ChatScreen();
                  }
                  return const AuthScreen();
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          })),
    );
  }
}
