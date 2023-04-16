import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/products_grid.dart';

class ProductOverViewScreen extends StatelessWidget {
  const ProductOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Overview'),
      ),
      body: const ProductsGrid(),
    );
  }
}
