import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments! as Map<String, String>;
    final mealId = routeArgs['id'] as String;
    return Scaffold(
      appBar: AppBar(title: Text(mealId)),
      body: Center(
        child: Text('The Meal = $mealId'),
      ),
    );
  }
}
