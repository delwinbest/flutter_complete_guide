import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});
  static const routeName = '/filters';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  SwitchListTile _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
          ),
          Text(
            "Adjust your meal selection.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-free', 'Only include Gluten-free meals.', _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarian', 'Only include Vegetarian meals.', _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include Vegan meals.', _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchListTile('Lactose-free',
                  'Only include Lactose-free meals.', _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}
