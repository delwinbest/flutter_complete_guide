import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
}
