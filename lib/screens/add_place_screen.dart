import 'dart:io';

import 'package:flutter/material.dart';
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

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
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
                const LocationInput()
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
