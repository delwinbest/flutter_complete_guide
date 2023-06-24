import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places_provider.dart';
import 'package:flutter_complete_guide/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: theme.copyWith(
            colorScheme: theme.colorScheme
                .copyWith(primary: Colors.indigo, secondary: Colors.amber)),
        home: const PlacesListScreeen(),
      ),
    );
  }
}
