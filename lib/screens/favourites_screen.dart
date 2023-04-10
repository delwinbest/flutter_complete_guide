import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key, required this.favouriteMeals});
  final List<Meal> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('You have no favourites yet'),
    );
  }
}
