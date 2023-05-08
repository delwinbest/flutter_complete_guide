import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // bool _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items];
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get favoriteProducts {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    Uri url = Uri(
        scheme: 'https',
        host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
        path: '/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite
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
      // print(error);
      rethrow;
    }
  }

  Future<void> fetchAndSetProducts() async {
    Uri url = Uri(
        scheme: 'https',
        host: 'flutter-update-900a1-default-rtdb.firebaseio.com',
        path: '/products.json');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      if (response.body == "null") return;

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite']));
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
        path: '/products/$id.json');
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
