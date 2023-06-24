import 'package:flutter/material.dart';

class PlacesListScreeen extends StatelessWidget {
  const PlacesListScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
