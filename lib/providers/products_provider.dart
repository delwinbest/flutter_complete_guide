import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  String authToken = '';
  String userId = '';
  List<Product> _items = [];

  ProductsProvider(
      {this.authToken = '',
      this.userId = '',
      List<Product> previousItems = const []})
      : _items = previousItems;

  // bool _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteProducts {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    Uri url = Uri(
        scheme: 'https',
        host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
        path: '/products.json',
        queryParameters: {"auth": authToken});
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetProducts() async {
    Uri url = Uri(
        scheme: 'https',
        host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
        path: '/products.json',
        queryParameters: {"auth": authToken});
    try {
      final productResponse = await http.get(url);
      if (productResponse.body == "null") return;
      final extractedData =
          json.decode(productResponse.body) as Map<String, dynamic>;
      url = Uri(
          scheme: 'https',
          host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
          path: '/userFavorites/$userId.json',
          queryParameters: {"auth": authToken});
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: favoriteData[productId] == null
                ? false
                : favoriteData[productId]['isFavorite'] ?? false));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    final prodIndex = _items
        .indexWhere((existingProduct) => existingProduct.id == product.id);
    if (prodIndex >= 0) {
      final Uri url = Uri(
          scheme: 'https',
          host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
          path: '/products/${product.id}.json');
      try {
        String body = json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        });
        http.Response response = await http.patch(url, body: body);
        if (response.statusCode != 200) throw Error();
        _items[prodIndex] = product;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
      return Future.value();
    }
  }

  Future<void> deleteProduct(String id) async {
    final Uri url = Uri(
        scheme: 'https',
        host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
        path: '/products/$id.json',
        queryParameters: {"auth": authToken});
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    Product existingProduct = _items[existingProductIndex];
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      throw const HttpException('Could not delete produce.');
    }
    _items.removeAt(existingProductIndex);
    notifyListeners();
    existingProduct.dispose();
    // _items.removeWhere((product) => product.id == id);
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
