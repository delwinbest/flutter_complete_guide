// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/auth_screet.dart';

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
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: Text('Connecting to database...'),
                  )
                : const AuthScreen();
          })),
    );
  }
}
