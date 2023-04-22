import 'dart:ffi';

import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String producId, double price, String title) {
    if (_items.containsKey(producId)) {
      _items.update(
          producId,
          (existingItem) => CartItem(
              id: producId,
              title: existingItem.title,
              quantity: (existingItem.quantity + 1),
              price: existingItem.price));
    } else {
      _items.putIfAbsent(
          producId,
          () =>
              CartItem(id: producId, title: title, quantity: 1, price: price));
    }
    notifyListeners();
  }
}