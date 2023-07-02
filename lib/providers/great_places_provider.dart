import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toIso8601String(),
        title: title,
        location: PlaceLocation(latitude: 10, longitude: 10),
        image: image);
    _items.add(newPlace);
    notifyListeners();
  }
}
