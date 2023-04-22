import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductOverViewScreen extends StatefulWidget {
  const ProductOverViewScreen({super.key});

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Overview'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    _showFavoritesOnly = true;
                  } else {
                    _showFavoritesOnly = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                        value: FilterOptions.favorites,
                        child: Text('Only Favorites')),
                    const PopupMenuItem(
                        value: FilterOptions.all, child: Text('Show All'))
                  ])
        ],
      ),
      body: ProductsGrid(showFavoritesOnly: _showFavoritesOnly),
    );
  }
}
