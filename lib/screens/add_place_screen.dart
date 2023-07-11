import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/place.dart';
import 'package:flutter_complete_guide/providers/great_places_provider.dart';
import 'package:flutter_complete_guide/widgets/image_input.dart';
import 'package:flutter_complete_guide/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = '/add-place';
  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double long) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a New Place')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(onSelectImage: _selectImage),
                const SizedBox(
                  height: 10,
                ),
                LocationInput(_selectPlace)
              ],
            ),
          ),
        )),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Theme.of(context).colorScheme.secondary),
          onPressed: () {
            _savePlace();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Place'),
        ),
      ]),
    );
  }
}
