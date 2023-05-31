import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_complete_guide/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final Uri url = Uri(
        scheme: 'https',
        host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
        path: '/userFavorites/$userId/$id.json',
        queryParameters: {"auth": authToken});
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      http.Response response =
          await http.put(url, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        throw HttpException('Unable to set favourite');
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
